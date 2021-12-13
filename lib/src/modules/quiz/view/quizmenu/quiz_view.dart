import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/view/quizmenu/components/body_quiz_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/appbar_gradient/appbar_gradient.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';

class QuizView extends StatefulWidget {
  const QuizView({Key? key}) : super(key: key);
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text(AppLocalizations.of(context)!.title_appbar_quiz_page,
            style: const TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: AppColors.background,
      body: const BodyQuiz(),
    );
  }
}
