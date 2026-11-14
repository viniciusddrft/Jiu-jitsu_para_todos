import 'package:jni/jni.dart';
import 'package:jni_flutter/jni_flutter.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interactor/interfaces/rules_service_interface.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interactor/rules_state.dart';

import 'pdf_downloader_bindings.g.dart' as native;

/// Salva o PDF em Downloads pela MediaStore (Kotlin `PdfDownloader`, chamado
/// via JNIgen). Não precisa de permissão de armazenamento no Android 10+.
class RulesServiceImpl implements RulesServiceInterface {
  @override
  Future<RulesState> downloadPDf(String url, String name) async {
    final context = androidApplicationContext.as(native.Context.type);
    final downloader = native.PdfDownloader(context);
    final jUrl = url.toJString();
    final jFileName = 'jiujitsu$name.pdf'.toJString();
    try {
      await downloader.saveToDownloads(jUrl, jFileName);
      return const SuccessDownload();
    } on JThrowable catch (error) {
      final message = error.message;
      error.release();
      return FailedDownload(message);
    } finally {
      jFileName.release();
      jUrl.release();
      downloader.release();
      context.release();
    }
  }
}
