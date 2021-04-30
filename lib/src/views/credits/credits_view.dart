import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jiu_jitsu_para_todos/src/views/shared/appbar_gradient/appbar_gradient.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreditsView extends StatefulWidget {
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
        title: Text('Créditos', style: TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: Color(0xff202848),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            Text(
              'Todos ícones do aplicativo são da Flaticon.',
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
            Text('O aplivativo foi desenvolvido em Flutter.',
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
                'Caso queira conhecer tanto o Flutter quanto a Flaticon basta clicar nos ícones.',
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
            Text(
              'Contato do desenvolvedor',
              style: TextStyle(fontSize: 15.sp),
            ),
            TextButton.icon(
              onPressed: () => _launchLink('mailto:viniciusddrft5@gmail.com'),
              icon: Icon(Icons.mail),
              label: Text(
                'E-mail de contato',
                style: TextStyle(fontSize: 15.sp),
              ),
            )
          ],
        ),
      ),
    );
  }
}
