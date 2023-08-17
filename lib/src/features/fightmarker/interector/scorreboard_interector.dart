import 'package:flutter/widgets.dart';

class ScoreboardInterector extends ChangeNotifier {
  int fighterPoints = 0;
  int punishmentsOfTheFighter = 0;
  int advantagesOfTheFighter = 0;

  void addPoints(int points) {
    fighterPoints += points;
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
    notifyListeners();
  }

  void removePunishments() {
    if (punishmentsOfTheFighter >= 1) {
      punishmentsOfTheFighter--;
    }
    notifyListeners();
  }
}
