import 'package:jni/jni.dart';
import 'package:jni_flutter/jni_flutter.dart';

import 'android_package_bindings.g.dart' as android;

/// Informações do app instalado, lidas direto do Android via JNI (bindings
/// JNIgen do SDK — `tool/jnigen.dart`), sem plugin nem MethodChannel.
abstract final class AppInfo {
  /// Versão do app (ex.: `3.3.3`). Vem do `version:` do pubspec.yaml, que o
  /// Flutter grava como `versionName` no APK — nunca precisa ser editada à mão.
  static final String version = _readVersionName();

  static String _readVersionName() {
    final context = androidApplicationContext.as(android.Context.type);
    final packageManager = context.packageManager!;
    final packageName = context.packageName!;
    final packageInfo = packageManager.getPackageInfo$3(packageName, 0)!;
    final versionName = packageInfo.versionName;
    try {
      return versionName?.toDartString() ?? '';
    } finally {
      for (final ref in <JObject?>[
        versionName,
        packageInfo,
        packageName,
        packageManager,
        context,
      ]) {
        ref?.release();
      }
    }
  }
}
