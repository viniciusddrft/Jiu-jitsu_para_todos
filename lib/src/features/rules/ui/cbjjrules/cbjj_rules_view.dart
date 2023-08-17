import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/components/admob_native_ad.dart';
import '../../../../shared/mixins/launch_link.dart';
import '../../../../shared/plugins/admob/admob_interector.dart';
import '../../../../shared/themes/app_colors.dart';

class CbjjrulesPage extends StatelessWidget with OpenLink {
  const CbjjrulesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final admobInterector = Modular.get<AdmobInterector>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.title_appbar_cbjj_rules_page,
          style: GoogleFonts.yatraOne(color: Colors.grey[700]),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
              child: Text(
                AppLocalizations.of(context)!.text_cbjj,
                style: GoogleFonts.ubuntu(fontSize: 16),
              ),
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                  fixedSize: const Size(200, 50),
                  elevation: 7,
                  foregroundColor: Colors.white,
                  backgroundColor: AppColors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  side: const BorderSide(color: Colors.white)),
              onPressed: () => openLink('https://cbjj.com.br/books-videos'),
              child: Center(
                child: Text(
                  AppLocalizations.of(context)!.text_button_cbjj,
                  style: GoogleFonts.ubuntu(fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: AdmobNativeAd(
          factoryId: 'listTile',
          adUnitId: admobInterector.nativeAdUnitIDListTile,
        ),
      ),
    );
  }
}
