import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/interfaces/ifirebase_quiz.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/question_entity.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/quiz_interactor.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/quiz_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_images.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../interactor/answer_entity.dart';
import 'components/button_quiz_widget.dart';

class QuizQuestionsPage extends StatefulWidget {
  final Difficult difficulty;
  const QuizQuestionsPage({super.key, required this.difficulty});

  @override
  State<QuizQuestionsPage> createState() => _QuizQuestionsPageState();
}

class _QuizQuestionsPageState extends State<QuizQuestionsPage> {
  final _quizInteractor = Modular.get<QuizInteractor>();
  final _pageController = PageController();
  final _timer = ValueNotifier<int>(10);

  @override
  void initState() {
    _quizInteractor.loadQuestions(widget.difficulty);
    _quizInteractor.playSoundTimer();
    _quizInteractor.addListener(() {
      if (_quizInteractor.value is QuizSuccess) {
        Timer.periodic(const Duration(seconds: 1), (timer) {
          if (mounted) {
            _timer.value--;
            if (_timer.value == 0) {
              _quizInteractor.onTimerFailed();
              _timer.value = 10;
              next();
            }
          }
        });
      }
    });
    super.initState();
  }

  void onPressedButton(AnswerEntity answerEntity) {
    _timer.value = 10;
    _quizInteractor.onPressed(answerEntity);
    next();
  }

  void next() {
    if (_pageController.page! + 1 == _quizInteractor.totalQuestions) {
      Modular.to.pushReplacementNamed('/quiz/result', arguments: {
        'score': _quizInteractor.score,
        'totalQuestions': _quizInteractor.totalQuestions,
        'difficult': _quizInteractor.difficult
      });
    } else {
      _pageController.animateToPage(_quizInteractor.numberQuestion,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOutCubicEmphasized);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: AppColors.background,
      body: ValueListenableBuilder(
        valueListenable: _quizInteractor,
        builder: (_, value, __) => switch (value) {
          QuizFailed() => Center(
              key: const Key('quizStateFailed'),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.withoutInternet,
                    width: 200,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      'Sem internet',
                      style: TextStyle(fontSize: 24),
                    ),
                  )
                ],
              ),
            ),
          QuizLoading() => const Center(
              key: Key('quizStateLoading'),
              child: CircularProgressIndicator(),
            ),
          QuizSuccess(questions: final List<QuestionEntity> questions) =>
            ValueListenableBuilder(
                valueListenable: _timer,
                builder: (_, value, __) {
                  return PageView(
                    key: const Key('quizStateSuccess'),
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      for (QuestionEntity question in questions)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: size.width * 0.07,
                                      bottom: size.height * 0.01),
                                  child: Text(
                                      'Quiz ${widget.difficulty == Difficult.easy ? AppLocalizations.of(context)!.text_difficultyname_white_belt : widget.difficulty == Difficult.medium ? AppLocalizations.of(context)!.text_difficultyname_blue_belt : AppLocalizations.of(context)!.text_difficultyname_black_belt}',
                                      style: GoogleFonts.yatraOne(
                                          fontSize: 20,
                                          color: Colors.grey[700])),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: size.width * 0.4,
                                      bottom: size.height * 0.01),
                                  child: Text(value.toString(),
                                      style: GoogleFonts.yatraOne(
                                          fontSize: 22,
                                          color: value > 7
                                              ? Colors.green
                                              : value > 3
                                                  ? Colors.yellow
                                                  : Colors.red)),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: size.width * 0.07),
                              child: Text(
                                  '${AppLocalizations.of(context)!.text_question} ${_quizInteractor.numberQuestion}/${_quizInteractor.totalQuestions}',
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 22, color: Colors.white)),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: size.width * 0.07,
                                  right: size.width * 0.07),
                              width: size.width,
                              height: 1,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                      Colors.white,
                                      AppColors.background
                                    ],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: size.height * 0.02,
                                  left: size.width * 0.07,
                                  right: size.width * 0.07),
                              child: Text(question.question,
                                  style: GoogleFonts.ubuntu(
                                      fontSize: 18, color: Colors.white)),
                            ),
                            const Spacer(),
                            for (AnswerEntity answerEntity in question.options)
                              Padding(
                                padding: EdgeInsets.only(
                                    left: size.width * 0.07,
                                    right: size.width * 0.07),
                                child: ButtonQuizQuestionsWidget(
                                  answerEntity: answerEntity,
                                  onPressedButton: onPressedButton,
                                ),
                              )
                          ],
                        )
                    ],
                  );
                })
        },
      ),
    );
  }

  @override
  void dispose() {
    _quizInteractor.dispose();
    _pageController.dispose();
    _timer.dispose();
    super.dispose();
  }
}
