import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/views/credits/credits_view.dart';
import 'package:jiu_jitsu_para_todos/src/views/shared/animated_page_route_builder/my_transition_elatic_out.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

class BodySettings extends StatefulWidget {
  final Locale locale;
  BodySettings({required this.locale});
  @override
  _BodySettingsState createState() => _BodySettingsState();
}

class _BodySettingsState extends State<BodySettings> {
  String _iconPath = '';

  @override
  void initState() {
    if (widget.locale == Locale('en', 'US')) {
      _iconPath = 'assets/images/languages/united-states.png';
    } else if (widget.locale == Locale('pt', 'BR')) {
      _iconPath = 'assets/images/languages/brasil.png';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//------------------------------------------------------------------------------
    void _changeCredits() async {
      await Navigator.of(context).push(MyTransitionElasticOut(
          route: CreditsView(), duration: Duration(milliseconds: 500)));
    }

//------------------------------------------------------------------------------
    Future<void> _changeLanguage() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.all(10),
            backgroundColor: Color(0xff202848),
            scrollable: true,
            content: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        context.setLocale(Locale('pt', 'BR'));
                        _iconPath = 'assets/images/languages/brasil.png';
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('text_brazilian_portugese'.tr()),
                          Image.asset(
                            'assets/images/languages/brasil.png',
                            width: 50.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      setState(() {
                        context.setLocale(Locale('en', 'US'));
                        _iconPath = 'assets/images/languages/united-states.png';
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('text_english_united_states'.tr()),
                          Image.asset(
                            'assets/images/languages/united-states.png',
                            width: 50.w,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    //--------------------------------------------------------------------------
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => _changeLanguage(),
              child: Container(
                color: Colors.transparent,
                width: MediaQuery.of(context).size.width / 1.6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'button_language_settings_page'.tr(),
                      style: TextStyle(fontSize: 18.sp),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 5,
                    ),
                    Image.asset(
                      _iconPath,
                      width: 50.w,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.5,
            ),
            Container(
              height: 50.h,
              width: 200.w,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    backgroundColor: Color(0xff202848),
                    primary: Colors.white,
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    side: BorderSide(color: Colors.white)),
                onPressed: _changeCredits,
                child: Center(
                  child: Text(
                    'button_credits_settings_page'.tr(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
