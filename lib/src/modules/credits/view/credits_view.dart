import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../shared/launch_link/launch_link.dart';
import '../../../shared/themes/app_colors.dart';

class CreditsView extends StatefulWidget {
  const CreditsView({super.key});
  @override
  State<CreditsView> createState() => _CreditsViewState();
}

class _CreditsViewState extends State<CreditsView> with OpenLink {
  late final Size size;

  @override
  void didChangeDependencies() {
    size = MediaQuery.of(context).size;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(
          AppLocalizations.of(context)!.title_appbar_credits_page,
          style: const TextStyle(fontFamily: 'YatraOne'),
        ),
      ),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const Spacer(),
          Flexible(
            flex: 2,
            child: Text(
              AppLocalizations.of(context)!
                  .text_all_application_icons_are_from_flaticon,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 2,
            child: TextButton.icon(
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
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const Spacer(),
          Flexible(
            flex: 2,
            child: TextButton.icon(
                onPressed: () => openLink('https://flutter.dev/'),
                icon: const FlutterLogo(
                  size: 100,
                ),
                label: const Text('')),
          ),
          const Spacer(),
          Flexible(
            flex: 2,
            child: SizedBox(
              width: size.width / 1.4,
              child: Text(
                AppLocalizations.of(context)!
                    .text_if_you_want_to_know_both_the_flutter_and_the_flaticon_just_click_on_the_icons,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
