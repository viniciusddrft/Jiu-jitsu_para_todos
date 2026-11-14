// Gera os bindings Dart (JNI) usados pelo app.
//
// Pré-requisito: compilar o app uma vez para gerar as classes Kotlin:
//   flutter build apk --debug
// Depois:
//   dart run tool/jnigen.dart
import 'package:jnigen/jnigen.dart';

const _kotlinClasses = 'build/app/tmp/kotlin-classes/debug/';

/// Membros do Android SDK usados pelo app (o resto das classes é excluído
/// para o binding não gerar milhares de métodos que nunca usamos).
const _androidSdkMembers = {
  'android.content.Context': {'getPackageManager', 'getPackageName'},
  'android.content.pm.PackageManager': {'getPackageInfo'},
  'android.content.pm.PackageInfo': {'versionName'},
};

void main() async {
  // Código Kotlin do próprio app: classe -> arquivo de bindings.
  const kotlinBindings = {
    'com.jiu_jitsu_para_todos.WallpaperSetter':
        'lib/src/shared/plugins/wallpaper/wallpaper_bindings.g.dart',
    'com.jiu_jitsu_para_todos.PdfDownloader':
        'lib/src/modules/rules/data/pdf_downloader_bindings.g.dart',
  };
  for (final MapEntry(key: className, value: output)
      in kotlinBindings.entries) {
    await JniGenerator(
      input: Input(
        classes: [className],
        classPath: [Uri.directory(_kotlinClasses)],
        androidSdk: AndroidSdk(addGradleDeps: true),
      ),
      output: Output(
        dart: DartOutput(
          path: Uri.file(output),
          structure: OutputStructure.singleFile,
        ),
      ),
    ).generate();
  }

  // Classes do Android SDK, sem código Kotlin próprio.
  Set<String> allowed = const {};
  await JniGenerator(
    input: Input(
      classes: _androidSdkMembers.keys.toList(),
      androidSdk: AndroidSdk(addGradleDeps: true),
    ),
    output: Output(
      dart: DartOutput(
        path: Uri.file(
            'lib/src/shared/plugins/app_info/android_package_bindings.g.dart'),
        structure: OutputStructure.singleFile,
      ),
    ),
    visitors: [
      Visitor(
        classDecl: (c) => allowed = _androidSdkMembers[c.binaryName] ?? const {},
        method: (m) => m.isIncluded = allowed.contains(m.originalName),
        field: (f) => f.isIncluded = allowed.contains(f.originalName),
      ),
    ],
  ).generate();
}
