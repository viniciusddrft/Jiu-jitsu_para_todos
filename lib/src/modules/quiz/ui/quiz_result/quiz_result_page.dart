import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../shared/components/app_card.dart';
import '../../../../shared/components/app_top_bar.dart';
import '../../../../shared/components/belt.dart';
import '../../../../shared/l10n/app_localizations.dart';
import '../../../../shared/plugins/admob/admob_interactor.dart';
import '../../../../shared/plugins/in_app_review/in_app_review_interactor.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_text_styles.dart';
import '../../interactor/interfaces/ifirebase_quiz.dart';
import '../difficulty_ui.dart';

class QuizResultPage extends StatefulWidget {
  final int score, totalQuestions;
  final Difficult difficult;

  const QuizResultPage(
      {required this.score,
      required this.difficult,
      required this.totalQuestions,
      super.key});
  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage>
    with SingleTickerProviderStateMixin {
  late final double _scorePercentage;
  late final String _scorePercentageText;
  late final AnimationController _animationController;

  final admobInteractor = inject<AdmobInteractor>();
  final inAppReviewInteractor = inject<InAppReviewInteractor>();

  @override
  void initState() {
    super.initState();

    _scorePercentage =
        widget.totalQuestions == 0 ? 0 : widget.score / widget.totalQuestions;
    _scorePercentageText = (_scorePercentage * 100).round().toString();

    _animationController = AnimationController(vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _animationController
          .animateTo(
            _scorePercentage,
            duration: const Duration(milliseconds: 1400),
            curve: Curves.easeOutCubic,
          )
          .whenComplete(_handleAfterAnimation);
    });
  }

  Future<void> _handleAfterAnimation() async {
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;

    final bool reviewHandled =
        await inAppReviewInteractor.registerQuizCompletionAndMaybeReview(
            scorePercentage: _scorePercentage);
    if (!mounted) return;

    if (!reviewHandled) admobInteractor.showInterstitialAd();
  }

  String _message(AppLocalizations l10n) {
    if (_scorePercentage == 1.0) return l10n.text_message_quiz_very_well;
    if (_scorePercentage >= 0.75) return l10n.text_message_quiz_almost;
    return l10n.text_message_quiz_sad;
  }

  String _resultLabel(AppLocalizations l10n) => switch (widget.difficult) {
        Difficult.easy => l10n.text_result_quiz_white_belt,
        Difficult.medium => l10n.text_result_quiz_blue_belt,
        Difficult.hard => l10n.text_result_quiz_black_belt,
      };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppTopBar(close: true, onBack: () => context.navigate('/')),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: BeltChip(
                      belt: Belt(belt: widget.difficult.belt),
                      label:
                          '${l10n.title_appbar_quiz_page} ${widget.difficult.beltName(context)}',
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(_resultLabel(l10n),
                      textAlign: TextAlign.center, style: AppTextStyles.body()),
                  const SizedBox(height: 24),
                  Center(
                    child: SizedBox(
                      width: 220,
                      height: 220,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          AnimatedBuilder(
                            animation: _animationController,
                            builder: (_, __) => CircularProgressIndicator(
                              value: _animationController.value,
                              strokeWidth: 16,
                              strokeCap: StrokeCap.butt,
                              trackGap: 0,
                              color: AppColors.accent,
                              backgroundColor: AppColors.surfaceHigh,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('$_scorePercentageText%',
                                  style: AppTextStyles.display(72)),
                              const SizedBox(height: 6),
                              Text(
                                  l10n.quiz_correct_count(
                                      widget.score, widget.totalQuestions),
                                  style: AppTextStyles.body(
                                      size: 14, color: AppColors.textMuted)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(_message(l10n).toUpperCase(),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.display(40)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                children: [
                  AppButton(
                    icon: Icons.replay_rounded,
                    label: l10n.quiz_play_again,
                    onPressed: () => context.replace('/quiz/questions',
                        arguments: widget.difficult),
                  ),
                  const SizedBox(height: 10),
                  AppButton(
                    primary: false,
                    label: l10n.quiz_back_home,
                    onPressed: () => context.navigate('/'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
