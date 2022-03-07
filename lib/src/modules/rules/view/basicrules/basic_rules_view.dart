import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/admob/controller/admob_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';

import '../../../../shared/admob/widget/admob_native_ad.dart';

class Basicrules extends StatefulWidget {
  const Basicrules({Key? key}) : super(key: key);
  @override
  _BasicrulesState createState() => _BasicrulesState();
}

class _BasicrulesState extends State<Basicrules> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppLocalizations.of(context)!.title_appbar_basic_rules_page,
          style: TextStyle(fontFamily: 'YatraOne', color: Colors.grey[700]),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: _size.width,
        height: _size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: _size.width * 0.9,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: _size.height * 0.03),
                      child: Text(
                        AppLocalizations.of(context)!.text_overview_title,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.text_overview,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: _size.height * 0.03),
                      child: Text(
                        AppLocalizations.of(context)!.text_scores_title,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.text_scores,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: _size.height * 0.03),
                      child: Text(
                        AppLocalizations.of(context)!
                            .text_moves_that_gives_2_scores_title,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.text_throws,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: _size.height * 0.03),
                      child: Text(
                        AppLocalizations.of(context)!.text_knee_in_belly,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.text_sweep,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: _size.height * 0.03),
                      child: Text(
                        AppLocalizations.of(context)!
                            .text_moves_that_gives_3_scores_title,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .text_moves_that_gives_3_scores,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: _size.height * 0.03),
                      child: Text(
                        AppLocalizations.of(context)!.text_guard_pass,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!
                          .text_moves_that_gives_4_scores_title,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: _size.height * 0.03),
                      child: Text(
                        AppLocalizations.of(context)!.text_mount,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.text_backward_grip,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: _size.height * 0.03),
                      child: Text(
                        AppLocalizations.of(context)!
                            .text_advantage_and_penalties_title,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: _size.height * 0.05),
                      child: Text(
                        AppLocalizations.of(context)!
                            .text_advantage_and_penalties,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
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
