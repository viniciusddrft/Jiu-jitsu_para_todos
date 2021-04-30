import 'package:jiu_jitsu_para_todos/src/controllers/quiz/quiz_controller.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:jiu_jitsu_para_todos/src/controllers/sound/controller_sound.dart';

main() {
  /*
    TEST README

    this test instantiates 2 controllers and tests whether they return all questions at random.
    they need to be the same size to be validated.
  */
  bool isQuestionsDifferents = false;
  ControllerQuiz _controllerquiz1 = ControllerQuiz();
  var myquestions1 = _controllerquiz1.choice('easy');
  ControllerQuiz _controllerquiz2 = ControllerQuiz();
  var myquestions2 = _controllerquiz2.choice('easy');

  //MySound mysound = MySound();

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
      if (_arrayTeste1 != _arrayTeste2) {
        isQuestionsDifferents = true;
        expect(isQuestionsDifferents, true);
      } else {
        expect(isQuestionsDifferents,
            true); //error as questions returned are equal
      }
    } else {
      expect(isQuestionsDifferents,
          true); //purposeful error if it returns different numbers of questions
    }
  });
}
