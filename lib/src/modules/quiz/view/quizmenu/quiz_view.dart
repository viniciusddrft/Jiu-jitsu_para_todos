import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../shared/appbar_gradient/appbar_gradient.dart';
import '../../../../shared/themes/app_colors.dart';
import 'components/body_quiz_widget.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});
  @override
  State<QuizView> createState() => _QuizViewState();
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
