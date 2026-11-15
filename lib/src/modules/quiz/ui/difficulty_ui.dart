import 'package:material_ui/material_ui.dart';

import '../../../shared/components/belt.dart';
import '../../../shared/l10n/app_localizations.dart';
import '../interactor/interfaces/ifirebase_quiz.dart';

/// Apresentação de cada nível do quiz. A faixa indica a DIFICULDADE das
/// perguntas, não a faixa de quem joga.
extension DifficultUi on Difficult {
  BeltColor get belt => switch (this) {
        Difficult.easy => BeltColor.white,
        Difficult.medium => BeltColor.blue,
        Difficult.hard => BeltColor.black,
      };

  /// "Faixa Branca", "Faixa Azul", "Faixa preta".
  String beltName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      Difficult.easy => l10n.text_difficultyname_white_belt,
      Difficult.medium => l10n.text_difficultyname_blue_belt,
      Difficult.hard => l10n.text_difficultyname_black_belt,
    };
  }

  /// "Nível Faixa Branca"...
  String levelName(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      Difficult.easy => l10n.button_white_belt_level,
      Difficult.medium => l10n.button_blue_belt_level,
      Difficult.hard => l10n.button_black_belt_level,
    };
  }

  String description(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return switch (this) {
      Difficult.easy => l10n.quiz_level_easy,
      Difficult.medium => l10n.quiz_level_medium,
      Difficult.hard => l10n.quiz_level_hard,
    };
  }
}
