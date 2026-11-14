// Gera os bindings Dart (JNI) para o código Kotlin do app.
//
// Pré-requisito: compilar o app uma vez para gerar as classes Kotlin:
//   flutter build apk --debug
// Depois:
//   dart run tool/jnigen.dart
import 'package:jnigen/jnigen.dart';

void main() async {
  await JniGenerator(
    input: Input(
      classes: ['com.jiu_jitsu_para_todos.WallpaperSetter'],
      classPath: [Uri.directory('build/app/tmp/kotlin-classes/debug/')],
      androidSdk: AndroidSdk(addGradleDeps: true),
    ),
    output: Output(
      dart: DartOutput(
        path: Uri.file('lib/src/shared/plugins/wallpaper/wallpaper_bindings.g.dart'),
        structure: OutputStructure.singleFile,
      ),
    ),
  ).generate();
}
