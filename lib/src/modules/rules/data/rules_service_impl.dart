import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interactor/interfaces/rules_service_interface.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interactor/rules_state.dart';

class RulesServiceImpl implements RulesServiceInterface {
  @override
  Future<RulesState> downloadPDf(String url, String name) async {
    try {
      final httpClient = HttpClient();
      final request = await httpClient.getUrl(Uri.parse(url));
      final response = await request.close();
      final bytes = await consolidateHttpClientResponseBytes(response);
      final file = File('/storage/emulated/0/Download/jiujitsu$name.pdf');
      await file.writeAsBytes(bytes);
      return const SuccessDownload();
    } catch (e) {
      return FailedDownload(e.toString());
    }
  }
}
