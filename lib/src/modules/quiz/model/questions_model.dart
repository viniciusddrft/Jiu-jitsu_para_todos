import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QuestionsModel {
  final String question;
  final List<String> options;
  final String rightAnswer;
  final String? pathImage;
  final String? pathVideo;
  const QuestionsModel({
    required this.question,
    required this.options,
    required this.rightAnswer,
    this.pathImage,
    this.pathVideo,
  });

  static List<QuestionsModel> questionsEasy(BuildContext context) {
    return _dataQuestionsEasy(context)
        .map(
          (question) => QuestionsModel(
              question: question['question'],
              options: question['options'],
              rightAnswer: question['rightAnswer'],
              pathImage: question?['pathImage'],
              pathVideo: question?['pathVideo']),
        )
        .toList();
  }

  static List<QuestionsModel> questionsMedium(BuildContext context) {
    return _dataQuestionsMedium(context)
        .map(
          (question) => QuestionsModel(
              question: question['question'],
              options: question['options'],
              rightAnswer: question['rightAnswer'],
              pathImage: question?['pathImage'],
              pathVideo: question?['pathVideo']),
        )
        .toList();
  }

  static List<QuestionsModel> questionsHard(BuildContext context) {
    return _dataQuestionsHard(context)
        .map(
          (question) => QuestionsModel(
              question: question['question'],
              options: question['options'],
              rightAnswer: question['rightAnswer'],
              pathImage: question?['pathImage'],
              pathVideo: question?['pathVideo']),
        )
        .toList();
  }

  static List _dataQuestionsEasy(BuildContext context) {
    return [
      {
        "question":
            AppLocalizations.of(context)!.quiz_white_belt_text_question1,
        "options": [
          AppLocalizations.of(context)!.quiz_white_belt_question1_option_a,
          AppLocalizations.of(context)!.quiz_white_belt_question1_option_b,
          AppLocalizations.of(context)!.quiz_white_belt_question1_option_c,
          AppLocalizations.of(context)!.quiz_white_belt_question1_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_white_belt_question1_option_a
      },
      {
        "question":
            AppLocalizations.of(context)!.quiz_white_belt_text_question2,
        "options": [
          AppLocalizations.of(context)!.quiz_white_belt_question2_option_a,
          AppLocalizations.of(context)!.quiz_white_belt_question2_option_b,
          AppLocalizations.of(context)!.quiz_white_belt_question2_option_c,
          AppLocalizations.of(context)!.quiz_white_belt_question2_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_white_belt_question2_option_a
      },
      {
        "question":
            AppLocalizations.of(context)!.quiz_white_belt_text_question3,
        "options": [
          AppLocalizations.of(context)!.quiz_white_belt_question3_option_a,
          AppLocalizations.of(context)!.quiz_white_belt_question3_option_b,
          AppLocalizations.of(context)!.quiz_white_belt_question3_option_c,
          AppLocalizations.of(context)!.quiz_white_belt_question3_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_white_belt_question3_option_a
      },
      {
        "question":
            AppLocalizations.of(context)!.quiz_white_belt_text_question4,
        "options": [
          AppLocalizations.of(context)!.quiz_white_belt_question4_option_a,
          AppLocalizations.of(context)!.quiz_white_belt_question4_option_b,
          AppLocalizations.of(context)!.quiz_white_belt_question4_option_c,
          AppLocalizations.of(context)!.quiz_white_belt_question4_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_white_belt_question4_option_a,
      },
      {
        "question":
            AppLocalizations.of(context)!.quiz_white_belt_text_question5,
        "options": [
          AppLocalizations.of(context)!.quiz_white_belt_question5_option_a,
          AppLocalizations.of(context)!.quiz_white_belt_question5_option_b,
          AppLocalizations.of(context)!.quiz_white_belt_question5_option_c,
          AppLocalizations.of(context)!.quiz_white_belt_question5_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_white_belt_question5_option_d
      },
      {
        "question":
            AppLocalizations.of(context)!.quiz_white_belt_text_question6,
        "options": [
          AppLocalizations.of(context)!.quiz_white_belt_question6_option_a,
          AppLocalizations.of(context)!.quiz_white_belt_question6_option_b,
          AppLocalizations.of(context)!.quiz_white_belt_question6_option_c,
          AppLocalizations.of(context)!.quiz_white_belt_question6_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_white_belt_question6_option_b
      },
      {
        "question":
            AppLocalizations.of(context)!.quiz_white_belt_text_question7,
        "options": [
          AppLocalizations.of(context)!.quiz_white_belt_question7_option_a,
          AppLocalizations.of(context)!.quiz_white_belt_question7_option_b,
          AppLocalizations.of(context)!.quiz_white_belt_question7_option_c,
          AppLocalizations.of(context)!.quiz_white_belt_question7_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_white_belt_question7_option_c
      },
      {
        "question":
            AppLocalizations.of(context)!.quiz_white_belt_text_question8,
        "options": [
          AppLocalizations.of(context)!.quiz_white_belt_question8_option_a,
          AppLocalizations.of(context)!.quiz_white_belt_question8_option_b,
          AppLocalizations.of(context)!.quiz_white_belt_question8_option_c,
          AppLocalizations.of(context)!.quiz_white_belt_question8_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_white_belt_question8_option_a
      },
      {
        "question":
            AppLocalizations.of(context)!.quiz_white_belt_text_question9,
        "options": [
          AppLocalizations.of(context)!.quiz_white_belt_question9_option_a,
          AppLocalizations.of(context)!.quiz_white_belt_question9_option_b,
          AppLocalizations.of(context)!.quiz_white_belt_question9_option_c,
          AppLocalizations.of(context)!.quiz_white_belt_question9_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_white_belt_question9_option_b,
      },
    ];
  }

  static List _dataQuestionsMedium(BuildContext context) {
    return [
      {
        "question": AppLocalizations.of(context)!.quiz_blue_belt_text_question1,
        "options": [
          AppLocalizations.of(context)!.quiz_blue_belt_question1_option_a,
          AppLocalizations.of(context)!.quiz_blue_belt_question1_option_b,
          AppLocalizations.of(context)!.quiz_blue_belt_question1_option_c,
          AppLocalizations.of(context)!.quiz_blue_belt_question1_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_blue_belt_question1_option_c
      },
      {
        "question": AppLocalizations.of(context)!.quiz_blue_belt_text_question2,
        "options": [
          AppLocalizations.of(context)!.quiz_blue_belt_question2_option_a,
          AppLocalizations.of(context)!.quiz_blue_belt_question2_option_b,
          AppLocalizations.of(context)!.quiz_blue_belt_question2_option_c,
          AppLocalizations.of(context)!.quiz_blue_belt_question2_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_blue_belt_question2_option_a
      },
      {
        "question": AppLocalizations.of(context)!.quiz_blue_belt_text_question3,
        "options": [
          AppLocalizations.of(context)!.quiz_blue_belt_question3_option_a,
          AppLocalizations.of(context)!.quiz_blue_belt_question3_option_b,
          AppLocalizations.of(context)!.quiz_blue_belt_question3_option_c,
          AppLocalizations.of(context)!.quiz_blue_belt_question3_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_blue_belt_question3_option_a
      },
      {
        "question": AppLocalizations.of(context)!.quiz_blue_belt_text_question4,
        "options": [
          AppLocalizations.of(context)!.quiz_blue_belt_question4_option_a,
          AppLocalizations.of(context)!.quiz_blue_belt_question4_option_b,
          AppLocalizations.of(context)!.quiz_blue_belt_question4_option_c,
          AppLocalizations.of(context)!.quiz_blue_belt_question4_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_blue_belt_question4_option_a
      },
      {
        "question": AppLocalizations.of(context)!.quiz_blue_belt_text_question5,
        "options": [
          AppLocalizations.of(context)!.quiz_blue_belt_question5_option_a,
          AppLocalizations.of(context)!.quiz_blue_belt_question5_option_b,
          AppLocalizations.of(context)!.quiz_blue_belt_question5_option_c,
          AppLocalizations.of(context)!.quiz_blue_belt_question5_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_blue_belt_question5_option_b
      },
      {
        "question": AppLocalizations.of(context)!.quiz_blue_belt_text_question6,
        "options": [
          AppLocalizations.of(context)!.quiz_blue_belt_question6_option_a,
          AppLocalizations.of(context)!.quiz_blue_belt_question6_option_b,
          AppLocalizations.of(context)!.quiz_blue_belt_question6_option_c,
          AppLocalizations.of(context)!.quiz_blue_belt_question6_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_blue_belt_question6_option_a
      },
    ];
  }

  static List _dataQuestionsHard(BuildContext context) {
    return [
      {
        "question":
            AppLocalizations.of(context)!.quiz_black_belt_text_question1,
        "options": [
          AppLocalizations.of(context)!.quiz_black_belt_question1_option_a,
          AppLocalizations.of(context)!.quiz_black_belt_question1_option_b,
          AppLocalizations.of(context)!.quiz_black_belt_question1_option_c,
          AppLocalizations.of(context)!.quiz_black_belt_question1_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_black_belt_question1_option_c
      },
      {
        "question":
            AppLocalizations.of(context)!.quiz_black_belt_text_question2,
        "options": [
          AppLocalizations.of(context)!.quiz_black_belt_question2_option_a,
          AppLocalizations.of(context)!.quiz_black_belt_question2_option_b,
          AppLocalizations.of(context)!.quiz_black_belt_question2_option_c,
          AppLocalizations.of(context)!.quiz_black_belt_question2_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_black_belt_question2_option_a
      },
      {
        "question":
            AppLocalizations.of(context)!.quiz_black_belt_text_question3,
        "options": [
          AppLocalizations.of(context)!.quiz_black_belt_question3_option_a,
          AppLocalizations.of(context)!.quiz_black_belt_question3_option_b,
          AppLocalizations.of(context)!.quiz_black_belt_question3_option_c,
          AppLocalizations.of(context)!.quiz_black_belt_question3_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_black_belt_question3_option_a
      },
      {
        "question":
            AppLocalizations.of(context)!.quiz_black_belt_text_question4,
        "options": [
          AppLocalizations.of(context)!.quiz_black_belt_question4_option_a,
          AppLocalizations.of(context)!.quiz_black_belt_question4_option_b,
          AppLocalizations.of(context)!.quiz_black_belt_question4_option_c,
          AppLocalizations.of(context)!.quiz_black_belt_question4_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_black_belt_question4_option_a
      },
      {
        "question":
            AppLocalizations.of(context)!.quiz_black_belt_text_question5,
        "options": [
          AppLocalizations.of(context)!.quiz_black_belt_question5_option_a,
          AppLocalizations.of(context)!.quiz_black_belt_question5_option_b,
          AppLocalizations.of(context)!.quiz_black_belt_question5_option_c,
          AppLocalizations.of(context)!.quiz_black_belt_question5_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_black_belt_question5_option_b
      },
      {
        "question":
            AppLocalizations.of(context)!.quiz_black_belt_text_question6,
        "options": [
          AppLocalizations.of(context)!.quiz_black_belt_question6_option_a,
          AppLocalizations.of(context)!.quiz_black_belt_question6_option_b,
          AppLocalizations.of(context)!.quiz_black_belt_question6_option_c,
          AppLocalizations.of(context)!.quiz_black_belt_question6_option_d
        ],
        "rightAnswer":
            AppLocalizations.of(context)!.quiz_black_belt_question6_option_d
      },
    ];
  }
}
