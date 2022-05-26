import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//Used for credits, settings page and cbjj rules

mixin OpenLink {
  Future<void> openLink(String url, {VoidCallback? onError}) async {
    try {
      if (!await launchUrl(Uri.parse(url),
          mode: LaunchMode.externalApplication)) {
        throw Exception('Error in url launcher | not implemented ');
      }
    } catch (error, stackStrace) {
      debugPrint(error.toString());
      debugPrint(stackStrace.toString());
    }
  }
}
