import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/shared/appbar_gradient/appbar_gradient.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class CreditsView extends StatefulWidget {
  const CreditsView();
  @override
  _CreditsViewState createState() => _CreditsViewState();
}

class _CreditsViewState extends State<CreditsView> {
  Future<void> _launchLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false, forceSafariVC: false);
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: AppBarGradient(),
        title: Text('title_appbar_credits_page'.tr(),
            style: TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: AppColors.background,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Text(
              'text_all_application_icons_are_from_flaticon'.tr(),
              style: TextStyle(fontSize: 15.sp),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            TextButton.icon(
                onPressed: () => _launchLink('https://www.flaticon.com/'),
                icon: Image.asset(
                  'assets/images/iconscredits/flaticon.png',
                  width: MediaQuery.of(context).size.width / 2,
                ),
                label: Text('')),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Text('text_the_application_was_developed_in_flutter'.tr(),
                style: TextStyle(fontSize: 15.sp)),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            TextButton.icon(
                onPressed: () => _launchLink('https://flutter.dev/'),
                icon: FlutterLogo(
                  size: 100,
                ),
                label: Text('')),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Text(
                'text_if_you_want_to_know_both_the_flutter_and_the_flaticon_just_click_on_the_icons'
                    .tr(),
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Text(
              'text_developer_contact'.tr(),
              style: TextStyle(fontSize: 15.sp),
            ),
            TextButton.icon(
              onPressed: () => _launchLink('mailto:viniciusddrft5@gmail.com'),
              icon: Icon(Icons.mail),
              label: Text(
                'text_contact_email'.tr(),
                style: TextStyle(fontSize: 15.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
