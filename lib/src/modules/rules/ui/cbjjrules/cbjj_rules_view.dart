import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interector/rules_interector.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interector/rules_state.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../shared/components/admob_native_ad.dart';
import '../../../../shared/plugins/admob/admob_interector.dart';
import '../../../../shared/themes/app_colors.dart';

class CbjjrulesPage extends StatefulWidget {
  const CbjjrulesPage({super.key});

  @override
  State<CbjjrulesPage> createState() => _CbjjrulesPageState();
}

class _CbjjrulesPageState extends State<CbjjrulesPage> {
  final admobInterector = Modular.get<AdmobInterector>();
  final rulesInterector = Modular.get<RulesInterector>();
  late final WebViewController controller;
  final urlPdf = ValueNotifier<String?>(null);

  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
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

    rulesInterector.addListener(() {
      if (rulesInterector.value is SuccessDownload) {
        showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
            title:
                Text(AppLocalizations.of(context)!.title_cbjj_successDownload),
          ),
        );
      } else if (rulesInterector.value is FailedDownload) {
        showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
            title:
                Text(AppLocalizations.of(context)!.title_cbjj_failedDownload),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    urlPdf.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([urlPdf, rulesInterector]),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            AppLocalizations.of(context)!.title_appbar_cbjj_rules_page,
            style: GoogleFonts.yatraOne(color: Colors.grey[700]),
          ),
        ),
        backgroundColor: AppColors.background,
        body: urlPdf.value == null
            ? WebViewWidget(controller: controller)
            : Stack(children: [
                SfPdfViewer.network(urlPdf.value!),
                if (rulesInterector.value is LoadingDownload)
                  const Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        color: AppColors.background,
                        strokeWidth: 5,
                      ),
                    ),
                  )
              ]),
        floatingActionButton:
            urlPdf.value != null && rulesInterector.value is! LoadingDownload
                ? FloatingActionButton(
                    onPressed: () => rulesInterector.downloadPDf(urlPdf.value!),
                    backgroundColor: AppColors.background,
                    child: const Icon(Icons.download),
                  )
                : null,
        bottomNavigationBar: SizedBox(
          height: 75,
          child: AdmobNativeAd(
            factoryId: 'listTile',
            adUnitId: admobInterector.nativeAdUnitIDListTile,
          ),
        ),
      ),
    );
  }
}
