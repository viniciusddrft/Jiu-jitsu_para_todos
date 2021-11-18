import 'package:flutter/foundation.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/controller/quiz_controller.dart';
import 'package:flutter_test/flutter_test.dart';

main() {
  /*
    TEST README

    this test instantiates 2 controllers and tests whether they return all questions at random.
    they need to be the same size to be validated.
  */
  int _numberOfDifferentQuestions = 0;
  bool _isQuestionsDifferents = false;
  ControllerQuiz _controllerquiz1 = ControllerQuiz();
  var myquestions1 = _controllerquiz1.choice('hard');
  ControllerQuiz _controllerquiz2 = ControllerQuiz();
  var myquestions2 = _controllerquiz2.choice('hard');

  test('deve retornar todas questões de forma aleatoria', () {
    List<String> _arrayTeste1 = [];
    for (int _i = 0; _i != myquestions1.length; _i++) {
      //print(myquestions1.toList()[_i].question);
      _arrayTeste1.add(myquestions1.toList()[_i].question);
    }
    List<String> _arrayTeste2 = [];
    for (int _i = 0; _i != myquestions2.length; _i++) {
      //print(myquestions2.toList()[_i].question);
      _arrayTeste2.add(myquestions2.toList()[_i].question);
    }

    if (_arrayTeste1.length == _arrayTeste2.length) {
      for (var _i = 0; _i != _arrayTeste1.length; _i++) {
        if (_arrayTeste1[_i] != _arrayTeste2[_i]) {
          _numberOfDifferentQuestions++;
          _isQuestionsDifferents = true;
        }
      }
      debugPrint('Of ' +
          _arrayTeste1.length.toString() +
          ' questions ' +
          _numberOfDifferentQuestions.toString() +
          ' were in different order');
      expect(_isQuestionsDifferents, true);
    } else {
      expect(_isQuestionsDifferents,
          true); //purposeful error if it returns different numbers of questions
    }
  });
}
