import 'package:flutter_modular/flutter_modular.dart';
import 'package:material_ui/material_ui.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../shared/components/app_card.dart';
import '../../../../shared/components/app_top_bar.dart';
import '../../../../shared/components/native_ad_slot.dart';
import '../../../../shared/l10n/app_localizations.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../interactor/rules_interactor.dart';
import '../../interactor/rules_state.dart';

class CbjjrulesPage extends StatefulWidget {
  const CbjjrulesPage({super.key});

  @override
  State<CbjjrulesPage> createState() => _CbjjrulesPageState();
}

class _CbjjrulesPageState extends State<CbjjrulesPage> {
  final rulesInteractor = inject<RulesInteractor>();
  late final WebViewController controller;
  final urlPdf = ValueNotifier<String?>(null);
  late final Listenable _bodyListenable =
      Listenable.merge([urlPdf, rulesInteractor]);

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(AppColors.background)
      ..setNavigationDelegate(
        NavigationDelegate(
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('cbjj.com.br/rails')) {
              urlPdf.value = request.url;
            }
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://cbjj.com.br/books-videos'));
    rulesInteractor.addListener(_onDownloadState);
  }

  void _onDownloadState() {
    final l10n = AppLocalizations.of(context)!;
    final message = switch (rulesInteractor.value) {
      SuccessDownload() => l10n.title_cbjj_successDownload,
      FailedDownload() => l10n.title_cbjj_failedDownload,
      _ => null,
    };
    if (message == null) return;
    final success = rulesInteractor.value is SuccessDownload;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(success ? Icons.check_circle_rounded : Icons.error_rounded,
              color: success ? AppColors.success : AppColors.accent),
          const SizedBox(width: 12),
          Expanded(child: Text(message)),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    rulesInteractor.removeListener(_onDownloadState);
    urlPdf.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            AppTopBar(eyebrow: l10n.title_appbar_cbjj_rules_page),
            Expanded(
              child: AnimatedBuilder(
                animation: _bodyListenable,
                builder: (context, child) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: urlPdf.value == null
                        ? WebViewWidget(controller: controller)
                        : Stack(children: [
                            SfPdfViewer.network(urlPdf.value!),
                            if (rulesInteractor.value is LoadingDownload)
                              const ColoredBox(
                                color: Color(0x880D1017),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                          ]),
                  ),
                ),
              ),
            ),
            AnimatedBuilder(
              animation: _bodyListenable,
              builder: (context, child) => urlPdf.value == null
                  ? const SizedBox(height: 8)
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                      child: AppButton(
                        icon: Icons.download_rounded,
                        label: l10n.rules_cbjj_save,
                        onPressed: rulesInteractor.value is LoadingDownload
                            ? null
                            : () => rulesInteractor.downloadPDf(urlPdf.value!),
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NativeAdSlot(),
    );
  }
}
