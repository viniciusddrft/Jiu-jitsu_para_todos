import 'package:url_launcher/url_launcher.dart';

//Used for credits and settings page
mixin OpenLink {
  Future<void> openLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: false, forceSafariVC: false);
    } else {} //no implemented
  }
}
