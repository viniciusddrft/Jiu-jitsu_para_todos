import 'package:flutter/foundation.dart';
import 'package:jni/jni.dart';
import 'package:jni_flutter/jni_flutter.dart';

import 'wallpaper_bindings.g.dart' as native;

enum WallpaperTarget {
  home(setHome: true, setLock: false),
  lock(setHome: false, setLock: true),
  both(setHome: true, setLock: true);

  const WallpaperTarget({required this.setHome, required this.setLock});

  final bool setHome;
  final bool setLock;
}

/// Define o papel de parede (Android) chamando o Kotlin `WallpaperSetter`
/// diretamente via JNI (bindings gerados por JNIgen — `tool/jnigen.dart`),
/// sem MethodChannel. A `suspend fun` do Kotlin roda em `Dispatchers.IO`,
/// então o `Future` não bloqueia a UI.
abstract final class WallpaperSetter {
  /// Retorna `true` em caso de sucesso, `false` se falhar.
  static Future<bool> setFromUrl(String url, WallpaperTarget target) async {
    final context = androidApplicationContext.as(native.Context.type);
    final setter = native.WallpaperSetter(context);
    final jUrl = url.toJString();
    try {
      await setter.setFromUrl(jUrl, target.setHome, target.setLock);
      return true;
    } on JThrowable catch (error) {
      debugPrint('Falha ao definir wallpaper: ${error.message}');
      error.release();
      return false;
    } finally {
      jUrl.release();
      setter.release();
      context.release();
    }
  }
}
