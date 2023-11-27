import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../shared/components/admob_native_ad.dart';
import '../../../../shared/plugins/admob/admob_interector.dart';
import '../../../../shared/themes/app_colors.dart';

class OriginOfJiujitsuPage extends StatelessWidget {
  const OriginOfJiujitsuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final admobInterector = Modular.get<AdmobInterector>();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.title_appbar_origin_of_jiujitsu_page,
          style: GoogleFonts.yatraOne(color: Colors.grey[700]),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.03),
                    child: Text(
                      AppLocalizations.of(context)!
                          .text_origin_of_jiujitsu_paragraph1,
                      style: GoogleFonts.ubuntu(fontSize: 16),
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .text_origin_of_jiujitsu_paragraph2,
                    style: GoogleFonts.ubuntu(fontSize: 16),
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .text_origin_of_jiujitsu_paragraph3,
                    style: GoogleFonts.ubuntu(fontSize: 16),
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .text_origin_of_jiujitsu_paragraph4,
                    style: GoogleFonts.ubuntu(fontSize: 16),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.05),
                    child: Text(
                      AppLocalizations.of(context)!
                          .text_origin_of_jiujitsu_paragraph5,
                      style: GoogleFonts.ubuntu(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
