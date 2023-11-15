import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/modules/rules/interector/rules_interector.dart';
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
          onProgress: (int progress) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (!request.url.contains('youtube')) {
              urlPdf.value = request.url;
            }
            return NavigationDecision.prevent;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://cbjj.com.br/books-videos'));
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
            : SfPdfViewer.network(urlPdf.value!),
        floatingActionButton: urlPdf.value != null
            ? FloatingActionButton(
                onPressed: () => rulesInterector.downloadPDf(urlPdf.value!))
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
