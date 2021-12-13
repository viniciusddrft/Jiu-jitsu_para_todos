import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/core/myapp.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}
