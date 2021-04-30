import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/views/quiz/components/botton_options_quiz_widget.dart';

class BodyQuiz extends StatefulWidget {
  @override
  _BodyQuizState createState() => _BodyQuizState();
}

class _BodyQuizState extends State<BodyQuiz> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            BottonOptionQuiz(
              imagebotton: 'assets/images/iconsbutton/faixabranca.png',
              textbotton: 'Nível Faixa Branca',
              difficulty: 'easy',
              difficultyname: 'Faixa Branca',
            ),
            BottonOptionQuiz(
              imagebotton: 'assets/images/iconsbutton/faixaazul.png',
              textbotton: 'Nível Faixa Azul',
              difficulty: 'medium',
              difficultyname: 'Faixa Azul',
            ),
            BottonOptionQuiz(
              imagebotton: 'assets/images/iconsbutton/faixapreta.png',
              textbotton: 'Nível Faixa Preta',
              difficulty: 'hard',
              difficultyname: 'Faixa Preta',
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            )
          ],
        ),
      ),
    );
  }
}
