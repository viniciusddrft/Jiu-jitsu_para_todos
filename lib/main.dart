import 'package:flutter/material.dart';

import 'core/myapp.dart';
import 'src/shared/admob/controller/admob_controller.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AdmobController.initialize();
  runApp(const MyApp());
}
