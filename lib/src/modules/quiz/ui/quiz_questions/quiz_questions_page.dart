import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../shared/components/app_card.dart';
import '../../../../shared/components/app_top_bar.dart';
import '../../../../shared/components/belt.dart';
import '../../../../shared/components/offline_state.dart';
import '../../../../shared/l10n/app_localizations.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_text_styles.dart';
import '../../interactor/answer_entity.dart';
import '../../interactor/interfaces/ifirebase_quiz.dart';
import '../../interactor/question_entity.dart';
import '../../interactor/quiz_interactor.dart';
import '../../interactor/quiz_state.dart';
import '../difficulty_ui.dart';
import 'components/button_quiz_widget.dart';
import 'components/quiz_media.dart';

class QuizQuestionsPage extends StatefulWidget {
  final Difficult difficulty;
  const QuizQuestionsPage({super.key, required this.difficulty});

  @override
  State<QuizQuestionsPage> createState() => _QuizQuestionsPageState();
}

class _QuizQuestionsPageState extends State<QuizQuestionsPage> {
  static const _secondsPerQuestion = 10;

  final _quizInteractor = inject<QuizInteractor>();
  final _pageController = PageController();
  final _timer = ValueNotifier<int>(_secondsPerQuestion);
  Timer? _countdownTimer;
  late final VoidCallback _stateListener;

  @override
  void initState() {
    super.initState();
    _quizInteractor.loadQuestions(widget.difficulty);
    _quizInteractor.playSoundTimer();
    _stateListener = () {
      if (_quizInteractor.value is QuizSuccess) {
        _startCountdown();
      }
    };
    _quizInteractor.addListener(_stateListener);
  }

  // Cria o cronômetro uma única vez. Sem o guard, cada notificação do
  // interactor em QuizSuccess (ex.: ao responder) criava um novo
  // Timer.periodic, acelerando a contagem e vazando timers.
  void _startCountdown() {
    if (_countdownTimer != null) return;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      _timer.value--;
      if (_timer.value == 0) {
        _quizInteractor.onTimerFailed();
        _timer.value = _secondsPerQuestion;
        next();
      }
    });
  }

  void onPressedButton(AnswerEntity answerEntity) {
    _timer.value = _secondsPerQuestion;
    _quizInteractor.onPressed(answerEntity);
    next();
  }

  void next() {
    if (_pageController.page! + 1 == _quizInteractor.totalQuestions) {
      context.replace('/quiz/result', arguments: {
        'score': _quizInteractor.score,
        'totalQuestions': _quizInteractor.totalQuestions,
        'difficult': _quizInteractor.difficult
      });
    } else {
      _pageController.animateToPage(_quizInteractor.numberQuestion,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubicEmphasized);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(
              close: true,
              trailing: BeltChip(
                belt: Belt(belt: widget.difficulty.belt),
                label: widget.difficulty.beltName(context),
              ),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: _quizInteractor,
                builder: (_, value, __) => switch (value) {
                  QuizFailed() => const OfflineState(
                      key: Key('quizStateFailed'),
                    ),
                  QuizLoading() => const Center(
                      key: Key('quizStateLoading'),
                      child: CircularProgressIndicator(),
                    ),
                  QuizSuccess(
                    questions: final List<QuestionEntity> questions
                  ) =>
                    PageView(
                      key: const Key('quizStateSuccess'),
                      controller: _pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        for (var i = 0; i < questions.length; i++)
                          _QuestionView(
                            question: questions[i],
                            index: i,
                            total: questions.length,
                            timer: _timer,
                            onAnswer: onPressedButton,
                          ),
                      ],
                    ),
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quizInteractor.removeListener(_stateListener);
    _countdownTimer?.cancel();
    _quizInteractor.dispose();
    _pageController.dispose();
    _timer.dispose();
    super.dispose();
  }
}

class _QuestionView extends StatelessWidget {
  const _QuestionView({
    required this.question,
    required this.index,
    required this.total,
    required this.timer,
    required this.onAnswer,
  });

  final QuestionEntity question;
  final int index, total;
  final ValueNotifier<int> timer;
  final void Function(AnswerEntity) onAnswer;

  /// Respostas curtas (pontos, "Vantagem"...) viram uma grade 2×2.
  bool get _compact =>
      question.options.length == 4 &&
      question.options.every((o) => o.text.length <= 12);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasMedia = QuizMedia.hasMedia(question);
    const letters = ['A', 'B', 'C', 'D', 'E', 'F'];

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(children: [
                    TextSpan(text: '${l10n.text_question.toUpperCase()} '),
                    TextSpan(
                        text: '${index + 1}',
                        style: const TextStyle(color: AppColors.text)),
                    TextSpan(text: ' / $total'),
                  ]),
                  style: AppTextStyles.title(20, color: AppColors.textMuted),
                ),
              ),
              ValueListenableBuilder<int>(
                valueListenable: timer,
                builder: (_, seconds, __) => Text(
                  '0:${seconds.toString().padLeft(2, '0')}',
                  style: AppTextStyles.display(28,
                      color: seconds <= 3 ? AppColors.accent : AppColors.text),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              for (var i = 0; i < total; i++) ...[
                if (i > 0) const SizedBox(width: 4),
                Expanded(
                  child: Container(
                    height: 4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: i < index
                          ? AppColors.text
                          : i == index
                              ? AppColors.accent
                              : AppColors.line,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        if (hasMedia) ...[
          const SizedBox(height: 20),
          QuizMedia(question: question),
        ],
        Padding(
          padding: EdgeInsets.fromLTRB(8, hasMedia ? 20 : 32, 8, 0),
          child: Text(question.question.toUpperCase(),
              style: AppTextStyles.title(hasMedia ? 28 : 32)),
        ),
        const SizedBox(height: 24),
        if (_compact)
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2.2,
            children: [
              for (final option in question.options)
                ButtonQuizQuestionsWidget(
                  answerEntity: option,
                  onPressedButton: onAnswer,
                  compact: true,
                ),
            ],
          )
        else
          for (var i = 0; i < question.options.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ButtonQuizQuestionsWidget(
                answerEntity: question.options[i],
                onPressedButton: onAnswer,
                letter: letters[i % letters.length],
              ),
            ),
      ],
    );
  }
}
