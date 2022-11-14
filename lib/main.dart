import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/core/locale/locale_app.dart';

import 'core/myapp.dart';
import 'src/shared/admob/controller/admob_controller.dart';
import 'src/shared/services/local_storage/interface/local_storage_interface.dart';
import 'src/shared/services/local_storage/local_storage_shared_preferrence.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AdmobController.initialize();

  final ILocalStorage localStorage = LocalStorageSharedPreferrence();

  runApp(
    LocaleApp(
      notifier: LocaleAppNotifier(
        localStorage: localStorage,
      ),
      child: const MyApp(),
    ),
  );
}
