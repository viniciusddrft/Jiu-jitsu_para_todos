import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../shared/admob/controller/admob_controller.dart';
import '../../../../shared/admob/widget/admob_native_ad.dart';
import '../../../../shared/themes/app_colors.dart';

class Basicrules extends StatelessWidget {
  const Basicrules({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.title_appbar_basic_rules_page,
          style: GoogleFonts.yatraOne(color: Colors.grey[700]),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                child: Text(
                  AppLocalizations.of(context)!.text_overview_title,
                  style: GoogleFonts.ubuntu(fontSize: 18),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.text_overview,
                style: GoogleFonts.ubuntu(fontSize: 16),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                child: Text(
                  AppLocalizations.of(context)!.text_scores_title,
                  style: GoogleFonts.ubuntu(fontSize: 18),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.text_scores,
                style: GoogleFonts.ubuntu(fontSize: 16),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                child: Text(
                  AppLocalizations.of(context)!
                      .text_moves_that_gives_2_scores_title,
                  style: GoogleFonts.ubuntu(fontSize: 18),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.text_throws,
                style: GoogleFonts.ubuntu(fontSize: 16),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                child: Text(
                  AppLocalizations.of(context)!.text_knee_in_belly,
                  style: GoogleFonts.ubuntu(fontSize: 16),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.text_sweep,
                style: GoogleFonts.ubuntu(fontSize: 16),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                child: Text(
                  AppLocalizations.of(context)!
                      .text_moves_that_gives_3_scores_title,
                  style: GoogleFonts.ubuntu(fontSize: 18),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.text_moves_that_gives_3_scores,
                style: GoogleFonts.ubuntu(fontSize: 16),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                child: Text(
                  AppLocalizations.of(context)!.text_guard_pass,
                  style: GoogleFonts.ubuntu(fontSize: 16),
                ),
              ),
              Text(
                AppLocalizations.of(context)!
                    .text_moves_that_gives_4_scores_title,
                style: GoogleFonts.ubuntu(fontSize: 18),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                child: Text(
                  AppLocalizations.of(context)!.text_mount,
                  style: GoogleFonts.ubuntu(fontSize: 16),
                ),
              ),
              Text(
                AppLocalizations.of(context)!.text_backward_grip,
                style: GoogleFonts.ubuntu(fontSize: 16),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                child: Text(
                  AppLocalizations.of(context)!
                      .text_advantage_and_penalties_title,
                  style: GoogleFonts.ubuntu(fontSize: 18),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size.height * 0.05),
                child: Text(
                  AppLocalizations.of(context)!.text_advantage_and_penalties,
                  style: GoogleFonts.ubuntu(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 75,
        child: AdmobNativeAd(
          factoryId: 'listTile',
          adUnitId: AdmobController.nativeAdUnitIDListTile,
        ),
      ),
    );
  }
}
