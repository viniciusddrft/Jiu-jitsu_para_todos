import 'package:flutter/widgets.dart';

/// Uma ação registrada no placar, para poder ser desfeita.
sealed class _ScoreAction {
  const _ScoreAction();
}

final class _PointsAction extends _ScoreAction {
  const _PointsAction(this.points);
  final int points;
}

final class _AdvantageAction extends _ScoreAction {
  const _AdvantageAction();
}

final class _PunishmentAction extends _ScoreAction {
  const _PunishmentAction();
}

class ScoreboardInteractor extends ChangeNotifier {
  int fighterPoints = 0;
  int punishmentsOfTheFighter = 0;
  int advantagesOfTheFighter = 0;

  final _history = <_ScoreAction>[];

  /// Há alguma ação para desfazer?
  bool get canUndo => _history.isNotEmpty;

  void addPoints(int points) {
    fighterPoints += points;
    _history.add(_PointsAction(points));
    notifyListeners();
  }

  void removePoints(int points) {
    if (fighterPoints >= points) {
      fighterPoints -= points;
    }
    notifyListeners();
  }

  void addAdvantages() {
    advantagesOfTheFighter++;
    _history.add(const _AdvantageAction());
    notifyListeners();
  }

  void removeAdvantages() {
    if (advantagesOfTheFighter >= 1) {
      advantagesOfTheFighter--;
    }
    notifyListeners();
  }

  void addPunishments() {
    punishmentsOfTheFighter++;
    _history.add(const _PunishmentAction());
    notifyListeners();
  }

  void removePunishments() {
    if (punishmentsOfTheFighter >= 1) {
      punishmentsOfTheFighter--;
    }
    notifyListeners();
  }

  /// Desfaz a última ação deste atleta (ponto, vantagem ou punição).
  void undo() {
    if (_history.isEmpty) return;
    switch (_history.removeLast()) {
      case _PointsAction(:final points):
        removePoints(points);
      case _AdvantageAction():
        removeAdvantages();
      case _PunishmentAction():
        removePunishments();
    }
  }
}
