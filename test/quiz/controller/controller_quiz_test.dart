import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/controller/quiz_controller.dart';
import 'package:jiu_jitsu_para_todos/src/shared/models/quiz/questions_model.dart';

void main() {
  /*
    TEST README

    this test instantiates 2 controllers and tests whether they return all questions at random.
    they need to be the same size to be validated.
  */

  test('must return all questions randomly', () async {
    int numberOfDifferentQuestions = 0;
    bool isQuestionsDifferents = false;

    final ControllerQuiz controllerquiz1 = ControllerQuiz();
    final List<QuestionModel> myQuestions1 = await controllerquiz1.choice(
        difficulty: 'hard',
        locale:
            const Locale.fromSubtags(languageCode: 'en', countryCode: 'US'));
    final ControllerQuiz controllerquiz2 = ControllerQuiz();
    final List<QuestionModel> myQuestions2 = await controllerquiz2.choice(
        difficulty: 'hard',
        locale:
            const Locale.fromSubtags(languageCode: 'en', countryCode: 'US'));

    List<String> arrayTeste1 = [];
    for (int i = 0; i != myQuestions1.length; i++) {
      arrayTeste1.add(myQuestions1.toList()[i].question);
    }
    List<String> arrayTeste2 = [];
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
}
