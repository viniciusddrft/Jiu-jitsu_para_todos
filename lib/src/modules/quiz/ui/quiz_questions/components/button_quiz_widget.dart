import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interactor/answer_entity.dart';
import '../../../../../shared/themes/app_colors.dart';
import '../../../interactor/quiz_interactor.dart';

class ButtonQuizQuestionsWidget extends StatefulWidget {
  final AnswerEntity answerEntity;
  final void Function(AnswerEntity answerEntity) onPressedButton;
  const ButtonQuizQuestionsWidget(
      {super.key, required this.answerEntity, required this.onPressedButton});

  @override
  State<ButtonQuizQuestionsWidget> createState() =>
      _ButtonQuizQuestionsWidgetState();
}

class _ButtonQuizQuestionsWidgetState extends State<ButtonQuizQuestionsWidget> {
  final _color = ValueNotifier<Color>(Colors.white);
  final _showIcon = ValueNotifier<bool>(false);
  final _quizInteractor = Modular.get<QuizInteractor>();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return AnimatedBuilder(
      animation: Listenable.merge([_color, _showIcon]),
      builder: (context, child) => Container(
        margin: EdgeInsets.only(bottom: size.height * 0.05),
        child: OutlinedButton(
          onPressed: () async {
            _showIcon.value = true;
            if (widget.answerEntity.isCorrect) {
              _color.value = Colors.green;
              _quizInteractor.playSoundRightAnswer();
            } else {
              _color.value = Colors.red;
              _quizInteractor.playSoundWrongAnswer();
            }
            await Future.delayed(const Duration(milliseconds: 500));
            widget.onPressedButton(widget.answerEntity);
          },
          style: OutlinedButton.styleFrom(
            elevation: 7,
            foregroundColor: _color.value,
            backgroundColor: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            side: BorderSide(color: _color.value),
            padding: const EdgeInsets.all(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.answerEntity.text,
                style: GoogleFonts.ubuntu(
                  fontSize: 16,
                  color: _color.value,
                ),
              ),
              Container(
                height: size.height * 0.03,
                width: size.height * 0.03,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: _color.value),
                ),
                child: Visibility(
                  visible: _showIcon.value,
                  child: Icon(
                    widget.answerEntity.isCorrect ? Icons.done : Icons.close,
                    size: 16,
                    color: _color.value,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _color.dispose();
    _showIcon.dispose();
    super.dispose();
  }
}
