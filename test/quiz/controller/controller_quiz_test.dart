import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/controller/quiz_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/models/quiz/questions_model.dart';

void main() {
  /*
    TEST README

    this test instantiates 2 controllers and tests whether they return all questions at random.
    they need to be the same size to be validated.
  */

  group('Quiz controller', () {
    test('must return all questions randomly', () async {
      int numberOfDifferentQuestions = 0;
      bool isQuestionsDifferents = false;

      final controllerquiz1 = ControllerQuiz();
      final List<QuestionModel> myQuestions1 = await controllerquiz1.choice(
          difficulty: 'hard',
          locale:
              const Locale.fromSubtags(languageCode: 'en', countryCode: 'US'));
      final controllerquiz2 = ControllerQuiz();
      final List<QuestionModel> myQuestions2 = await controllerquiz2.choice(
          difficulty: 'hard',
          locale:
              const Locale.fromSubtags(languageCode: 'en', countryCode: 'US'));

      final List<String> arrayTeste1 = [];
      for (int i = 0; i != myQuestions1.length; i++) {
        arrayTeste1.add(myQuestions1.toList()[i].question);
      }
      final List<String> arrayTeste2 = [];
      for (int i = 0; i != myQuestions2.length; i++) {
        arrayTeste2.add(myQuestions2.toList()[i].question);
      }

      if (arrayTeste1.length == arrayTeste2.length) {
        for (var i = 0; i != arrayTeste1.length; i++) {
          if (arrayTeste1[i] != arrayTeste2[i]) {
            numberOfDifferentQuestions++;
            isQuestionsDifferents = true;
          }
        }
        debugPrint(
            'Of ${arrayTeste1.length} questions $numberOfDifferentQuestions were in different order');
        expect(isQuestionsDifferents, true);
      } else {
        expect(isQuestionsDifferents, true);
      }
    });

    test('quizController funções', () async {
      final controllerquiz = ControllerQuiz();

      final List<QuestionModel> myQuestions = await controllerquiz.choice(
          difficulty: 'hard',
          locale:
              const Locale.fromSubtags(languageCode: 'en', countryCode: 'US'));

      bool functionsOK = false;
      expect(controllerquiz.score, 0);
      expect(controllerquiz.indexCurrentQuestion, 0);
      try {
        controllerquiz.textQuestionReturn(myQuestions);
        controllerquiz.returnTextAnswerA(myQuestions);
        controllerquiz.returnTextAnswerB(myQuestions);
        controllerquiz.returnTextAnswerC(myQuestions);
        controllerquiz.returnTextAnswerD(myQuestions);
        controllerquiz.returnPathImage(myQuestions);
        controllerquiz.returnPathVideo(myQuestions);
        controllerquiz.addScore();
        controllerquiz.nextQuestion();
        functionsOK = true;
      } catch (e) {
        functionsOK = false;
      }

      expect(functionsOK, true);
      expect(controllerquiz.score, 1);
      expect(controllerquiz.indexCurrentQuestion, 1);
    });

    test('quizController paint buttons', () async {
      final controllerquiz = ControllerQuiz();

      controllerquiz.paintButtonA(isRight: true);
      expect(controllerquiz.colorButtonA, Colors.green);
      expect(controllerquiz.colorIconButtonA, Colors.green);

      controllerquiz.paintButtonA(isRight: false);
      expect(controllerquiz.colorButtonA, Colors.red);
      expect(controllerquiz.colorIconButtonA, Colors.red);

      controllerquiz.paintButtonB(isRight: true);
      expect(controllerquiz.colorButtonB, Colors.green);
      expect(controllerquiz.colorIconButtonB, Colors.green);

      controllerquiz.paintButtonB(isRight: false);
      expect(controllerquiz.colorButtonB, Colors.red);
      expect(controllerquiz.colorIconButtonB, Colors.red);

      controllerquiz.paintButtonC(isRight: true);
      expect(controllerquiz.colorButtonC, Colors.green);
      expect(controllerquiz.colorIconButtonC, Colors.green);

      controllerquiz.paintButtonC(isRight: false);
      expect(controllerquiz.colorButtonC, Colors.red);
      expect(controllerquiz.colorIconButtonC, Colors.red);

      controllerquiz.paintButtonD(isRight: true);
      expect(controllerquiz.colorButtonD, Colors.green);
      expect(controllerquiz.colorIconButtonD, Colors.green);

      controllerquiz.paintButtonD(isRight: false);
      expect(controllerquiz.colorButtonD, Colors.red);
      expect(controllerquiz.colorIconButtonD, Colors.red);

      controllerquiz.cleanButtons();
      expect(controllerquiz.colorButtonA, Colors.white);
      expect(controllerquiz.colorButtonB, Colors.white);
      expect(controllerquiz.colorButtonC, Colors.white);
      expect(controllerquiz.colorButtonD, Colors.white);
    });
  });
}
