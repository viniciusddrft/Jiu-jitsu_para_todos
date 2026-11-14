import 'package:material_ui/material_ui.dart';

import '../../../../../shared/themes/app_colors.dart';
import '../../../../../shared/themes/app_text_styles.dart';
import '../../../interactor/answer_entity.dart';

enum _AnswerState { idle, correct, wrong }

/// Alternativa do quiz. Em lista mostra a letra (A, B, C...); em grade
/// (respostas curtas, como pontos) mostra só o texto grande.
class ButtonQuizQuestionsWidget extends StatefulWidget {
  const ButtonQuizQuestionsWidget({
    super.key,
    required this.answerEntity,
    required this.onPressedButton,
    this.letter,
    this.compact = false,
  });

  final AnswerEntity answerEntity;
  final void Function(AnswerEntity answerEntity) onPressedButton;
  final String? letter;
  final bool compact;

  @override
  State<ButtonQuizQuestionsWidget> createState() =>
      _ButtonQuizQuestionsWidgetState();
}

class _ButtonQuizQuestionsWidgetState extends State<ButtonQuizQuestionsWidget> {
  _AnswerState _state = _AnswerState.idle;

  Future<void> _onTap() async {
    if (_state != _AnswerState.idle) return;
    setState(() => _state = widget.answerEntity.isCorrect
        ? _AnswerState.correct
        : _AnswerState.wrong);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    widget.onPressedButton(widget.answerEntity);
  }

  @override
  Widget build(BuildContext context) {
    final (background, border, borderWidth) = switch (_state) {
      _AnswerState.idle => (AppColors.surface, AppColors.line, 1.0),
      _AnswerState.correct => (
          AppColors.successSurface,
          AppColors.success,
          2.0
        ),
      _AnswerState.wrong => (AppColors.errorSurface, AppColors.accent, 2.0),
    };
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: BorderSide(color: border, width: borderWidth),
    );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      child: Material(
        color: background,
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: _onTap,
          child: widget.compact ? _compact() : _row(),
        ),
      ),
    );
  }

  Widget _badge() {
    final (color, child) = switch (_state) {
      _AnswerState.idle => (
          AppColors.surfaceHigh,
          Text(widget.letter ?? '', style: AppTextStyles.label(size: 13))
              as Widget
        ),
      _AnswerState.correct => (
          AppColors.success,
          const Icon(Icons.check_rounded, size: 18, color: AppColors.background)
        ),
      _AnswerState.wrong => (
          AppColors.accent,
          const Icon(Icons.close_rounded, size: 18, color: AppColors.background)
        ),
    };
    return Container(
      width: 32,
      height: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: child,
    );
  }

  Widget _row() => ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 60),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              _badge(),
              const SizedBox(width: 14),
              Expanded(
                child: Text(widget.answerEntity.text,
                    style: AppTextStyles.body(
                        size: 15, color: AppColors.text, height: 1.35)),
              ),
            ],
          ),
        ),
      );

  Widget _compact() => SizedBox(
        height: 76,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_state != _AnswerState.idle) ...[
                _badge(),
                const SizedBox(width: 10),
              ],
              Flexible(
                child: Text(widget.answerEntity.text.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.display(28).copyWith(height: 1)),
              ),
            ],
          ),
        ),
      );
}
