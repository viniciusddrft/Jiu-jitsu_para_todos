import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/core/myapp.dart';

import 'src/shared/admob/controller/admob_controller.dart';

void main() {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    AdmobController.initialize();
  } catch (error, stackTrace) {
    debugPrint(error.toString());
    debugPrint(stackTrace.toString());
  }

  runApp(const MyApp());
}
