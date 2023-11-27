import 'dart:math';
import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interector/interfaces/rules_service_interface.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interector/rules_state.dart';
import 'package:permission_handler/permission_handler.dart';

class RulesInterector extends ValueNotifier<RulesState> {
  RulesInterector(this.rulesService) : super(const InitialRules());

  final RulesServiceInterface rulesService;

  void downloadPDf(String url) async {
    value = const LoadingDownload();
    final PermissionStatus status = await Permission.storage.status;
    if (status.isDenied) await Permission.storage.request();
    final newState = await rulesService.downloadPDf(url, generateName());
    value = newState;
  }

  String generateName() {
    final random = Random();
    const String letter = 'abcdefghijklmnopqrstuvwxyz';
    String name = '';

    for (int i = 0; i < 10; i++) {
      final int randomIndex = random.nextInt(letter.length);
      name += letter[randomIndex];
    }

    return name;
  }
}
