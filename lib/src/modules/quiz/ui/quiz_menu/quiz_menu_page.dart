import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interector/interfaces/ifirebase_quiz.dart';
import '../../../../shared/components/app_bar_gradient.dart';
import '../../../../shared/components/button_menu.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_icons_path.dart';

class QuizMenuPage extends StatelessWidget {
  const QuizMenuPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_quiz_page,
            style: GoogleFonts.yatraOne()),
      ),
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ButtonMenu(
              imageButton: AppIconsPath.faixaBranca,
              text: AppLocalizations.of(context)!.button_white_belt_level,
              onPressed: () => Modular.to
                  .pushNamed('/quiz/questions', arguments: Difficult.easy),
            ),
            ButtonMenu(
              imageButton: AppIconsPath.faixaAzul,
              text: AppLocalizations.of(context)!.button_blue_belt_level,
              onPressed: () => Modular.to
                  .pushNamed('/quiz/questions', arguments: Difficult.medium),
            ),
            ButtonMenu(
              imageButton: AppIconsPath.faixaPreta,
              text: AppLocalizations.of(context)!.button_black_belt_level,
              onPressed: () => Modular.to
                  .pushNamed('/quiz/questions', arguments: Difficult.hard),
            ),
          ],
        ),
      ),
    );
  }
}
