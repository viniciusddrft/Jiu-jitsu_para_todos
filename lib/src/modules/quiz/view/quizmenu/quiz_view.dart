import 'package:flutter/material.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/view/quizmenu/components/body_quiz_widget.dart';
import 'package:jiu_jitsu_para_todos/src/shared/appbar_gradient/appbar_gradient.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:jiu_jitsu_para_todos/src/shared/themes/app_colors.dart';

class QuizView extends StatefulWidget {
  const QuizView();
  @override
  _QuizViewState createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const AppBarGradient(),
        title: Text('title_appbar_quiz_page'.tr(),
            style: const TextStyle(fontFamily: 'YatraOne')),
      ),
      backgroundColor: AppColors.background,
      body: const BodyQuiz(),
    );
  }
}
