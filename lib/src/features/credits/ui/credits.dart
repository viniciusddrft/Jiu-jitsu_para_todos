import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../shared/components/app_bar_gradient.dart';
import '../../../shared/mixins/launch_link.dart';
import '../../../shared/themes/app_colors.dart';

class CreditsPage extends StatelessWidget with OpenLink {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(
          AppLocalizations.of(context)!.title_appbar_credits_page,
          style: GoogleFonts.yatraOne(),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SizedBox(
        width: size.width,
        child: Column(
          children: [
            const Spacer(),
            Flexible(
              flex: 2,
              child: Text(
                AppLocalizations.of(context)!
                    .text_all_application_icons_are_from_flaticon,
                style: GoogleFonts.ubuntu(fontSize: 14),
                key: const Key('text flaticon'),
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 2,
              child: TextButton.icon(
                key: const Key('icon flaticon'),
                onPressed: () => openLink('https://www.flaticon.com/'),
                icon: Image.asset(
                  'assets/images/iconscredits/flaticon.png',
                  width: size.width / 2,
                ),
                label: const Text(''),
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 2,
              child: Text(
                AppLocalizations.of(context)!
                    .text_the_application_was_developed_in_flutter,
                style: GoogleFonts.ubuntu(fontSize: 14),
                key: const Key('text flutter'),
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 2,
              child: TextButton.icon(
                key: const Key('icon flutter'),
                onPressed: () => openLink('https://flutter.dev/'),
                icon: const FlutterLogo(
                  size: 100,
                ),
                label: const Text(''),
              ),
            ),
            const Spacer(),
            Flexible(
              flex: 2,
              child: SizedBox(
                width: size.width / 1.4,
                child: Text(
                  AppLocalizations.of(context)!
                      .text_if_you_want_to_know_both_the_flutter_and_the_flaticon_just_click_on_the_icons,
                  style: GoogleFonts.ubuntu(fontSize: 14),
                  key: const Key('text click'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
