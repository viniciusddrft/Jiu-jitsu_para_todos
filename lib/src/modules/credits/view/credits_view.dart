import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/shared/appbar_gradient/appbar_gradient.dart';
import 'package:jiu_jitsu_para_todos/src/shared/launch_link/launch_link.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreditsView extends StatefulWidget {
  const CreditsView({Key? key}) : super(key: key);
  @override
  _CreditsViewState createState() => _CreditsViewState();
}

class _CreditsViewState extends State<CreditsView> with OpenLink {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_credits_page,
            style: const TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Text(
              AppLocalizations.of(context)!
                  .text_all_application_icons_are_from_flaticon,
              style: TextStyle(fontSize: 15.sp),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            TextButton.icon(
                onPressed: () => openLink('https://www.flaticon.com/'),
                icon: Image.asset(
                  'assets/images/iconscredits/flaticon.png',
                  width: MediaQuery.of(context).size.width / 2,
                ),
                label: const Text('')),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Text(
                AppLocalizations.of(context)!
                    .text_the_application_was_developed_in_flutter,
                style: TextStyle(fontSize: 15.sp)),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            TextButton.icon(
                onPressed: () => openLink('https://flutter.dev/'),
                icon: const FlutterLogo(
                  size: 100,
                ),
                label: const Text('')),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Text(
                AppLocalizations.of(context)!
                    .text_if_you_want_to_know_both_the_flutter_and_the_flaticon_just_click_on_the_icons,
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
