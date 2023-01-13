import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/core/locale/locale_app.dart';

import 'core/myapp.dart';
import 'src/shared/admob/controller/admob_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AdmobController.initialize();

  runApp(
    LocaleApp(
      notifier: LocaleAppNotifier(),
      child: AdmobApp(
        notifier: AdmobController(),
        child: const MyApp(),
      ),
    ),
  );
}
