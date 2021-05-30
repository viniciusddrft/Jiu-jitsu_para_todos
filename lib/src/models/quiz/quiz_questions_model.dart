import 'package:easy_localization/easy_localization.dart';

class Question {
  final String question;
  final List<String> options;
  final String rightanswer;
  final String? pathImage;
  final String? pathVideo;
  Question({
    required this.question,
    required this.options,
    required this.rightanswer,
    this.pathImage,
    this.pathVideo,
  });
}

final List dataquestionseasy = [
  {
    "question": "quiz_white_belt_text_question1".tr(),
    "options": [
      'quiz_white_belt_question1_option_a'.tr(),
      'quiz_white_belt_question1_option_b'.tr(),
      'quiz_white_belt_question1_option_c'.tr(),
      'quiz_white_belt_question1_option_d'.tr()
    ],
    "rightanswer": "quiz_white_belt_question1_option_a".tr()
  },
  {
    "question": "quiz_white_belt_text_question2".tr(),
    "options": [
      'quiz_white_belt_question2_option_a'.tr(),
      'quiz_white_belt_question2_option_b'.tr(),
      'quiz_white_belt_question2_option_c'.tr(),
      'quiz_white_belt_question2_option_d'.tr()
    ],
    "rightanswer": "quiz_white_belt_question2_option_a".tr()
  },
  {
    "question": "quiz_white_belt_text_question3".tr(),
    "options": [
      'quiz_white_belt_question3_option_a'.tr(),
      'quiz_white_belt_question3_option_b'.tr(),
      'quiz_white_belt_question3_option_c'.tr(),
      'quiz_white_belt_question3_option_d'.tr()
    ],
    "rightanswer": "quiz_white_belt_question3_option_a".tr()
  },
  {
    "question": "quiz_white_belt_text_question4".tr(),
    "options": [
      'quiz_white_belt_question4_option_a'.tr(),
      'quiz_white_belt_question4_option_b'.tr(),
      'quiz_white_belt_question4_option_c'.tr(),
      'quiz_white_belt_question4_option_d'.tr()
    ],
    "rightanswer": "quiz_white_belt_question4_option_a".tr(),
  },
  {
    "question": "quiz_white_belt_text_question5".tr(),
    "options": [
      'quiz_white_belt_question5_option_a'.tr(),
      'quiz_white_belt_question5_option_b'.tr(),
      'quiz_white_belt_question5_option_c'.tr(),
      'quiz_white_belt_question5_option_d'.tr()
    ],
    "rightanswer": "quiz_white_belt_question5_option_d".tr()
  },
  {
    "question": "quiz_white_belt_text_question6".tr(),
    "options": [
      'quiz_white_belt_question6_option_a'.tr(),
      'quiz_white_belt_question6_option_b'.tr(),
      'quiz_white_belt_question6_option_c'.tr(),
      'quiz_white_belt_question6_option_d'.tr()
    ],
    "rightanswer": "quiz_white_belt_question6_option_b".tr()
  },
  {
    "question": "quiz_white_belt_text_question7".tr(),
    "options": [
      'quiz_white_belt_question7_option_a'.tr(),
      'quiz_white_belt_question7_option_b'.tr(),
      'quiz_white_belt_question7_option_c'.tr(),
      'quiz_white_belt_question7_option_d'.tr()
    ],
    "rightanswer": "quiz_white_belt_question7_option_c".tr()
  },
  {
    "question": "quiz_white_belt_text_question8".tr(),
    "options": [
      'quiz_white_belt_question8_option_a'.tr(),
      'quiz_white_belt_question8_option_b'.tr(),
      'quiz_white_belt_question8_option_c'.tr(),
      'quiz_white_belt_question8_option_d'.tr()
    ],
    "rightanswer": "quiz_white_belt_question8_option_a".tr()
  },
  {
    "question": "quiz_white_belt_text_question9".tr(),
    "options": [
      'quiz_white_belt_question9_option_a'.tr(),
      'quiz_white_belt_question9_option_b'.tr(),
      'quiz_white_belt_question9_option_c'.tr(),
      'quiz_white_belt_question9_option_d'.tr()
    ],
    "rightanswer": "quiz_white_belt_question9_option_b".tr(),
  },
];

final List dataquestionsmedium = [
  {
    "question": "quiz_blue_belt_text_question1".tr(),
    "options": [
      'quiz_blue_belt_question1_option_a'.tr(),
      'quiz_blue_belt_question1_option_b'.tr(),
      'quiz_blue_belt_question1_option_c'.tr(),
      'quiz_blue_belt_question1_option_d'.tr()
    ],
    "rightanswer": "quiz_blue_belt_question1_option_c".tr()
  },
  {
    "question": "quiz_blue_belt_text_question2".tr(),
    "options": [
      'quiz_blue_belt_question2_option_a'.tr(),
      'quiz_blue_belt_question2_option_b'.tr(),
      'quiz_blue_belt_question2_option_c'.tr(),
      'quiz_blue_belt_question2_option_d'.tr()
    ],
    "rightanswer": "quiz_blue_belt_question2_option_a".tr()
  },
  {
    "question": "quiz_blue_belt_text_question3".tr(),
    "options": [
      'quiz_blue_belt_question3_option_a'.tr(),
      'quiz_blue_belt_question3_option_b'.tr(),
      'quiz_blue_belt_question3_option_c'.tr(),
      'quiz_blue_belt_question3_option_d'.tr()
    ],
    "rightanswer": "quiz_blue_belt_question3_option_a".tr()
  },
  {
    "question": "quiz_blue_belt_text_question4".tr(),
    "options": [
      'quiz_blue_belt_question4_option_a'.tr(),
      'quiz_blue_belt_question4_option_b'.tr(),
      'quiz_blue_belt_question4_option_c'.tr(),
      'quiz_blue_belt_question4_option_d'.tr()
    ],
    "rightanswer": "quiz_blue_belt_question4_option_a".tr()
  },
  {
    "question": "quiz_blue_belt_text_question5".tr(),
    "options": [
      'quiz_blue_belt_question5_option_a'.tr(),
      'quiz_blue_belt_question5_option_b'.tr(),
      'quiz_blue_belt_question5_option_c'.tr(),
      'quiz_blue_belt_question5_option_d'.tr()
    ],
    "rightanswer": "quiz_blue_belt_question5_option_b".tr()
  },
  {
    "question": "quiz_blue_belt_text_question6".tr(),
    "options": [
      'quiz_blue_belt_question6_option_a'.tr(),
      'quiz_blue_belt_question6_option_b'.tr(),
      'quiz_blue_belt_question6_option_c'.tr(),
      'quiz_blue_belt_question6_option_d'.tr()
    ],
    "rightanswer": "quiz_blue_belt_question6_option_a".tr()
  },
];

final List dataquestionshard = [
  {
    "question": "quiz_black_belt_text_question1".tr(),
    "options": [
      'quiz_black_belt_question1_option_a'.tr(),
      'quiz_black_belt_question1_option_b'.tr(),
      'quiz_black_belt_question1_option_c'.tr(),
      'quiz_black_belt_question1_option_d'.tr()
    ],
    "rightanswer": "quiz_black_belt_question1_option_c".tr()
  },
  {
    "question": "quiz_black_belt_text_question2".tr(),
    "options": [
      'quiz_black_belt_question2_option_a'.tr(),
      'quiz_black_belt_question2_option_b'.tr(),
      'quiz_black_belt_question2_option_c'.tr(),
      'quiz_black_belt_question2_option_d'.tr()
    ],
    "rightanswer": "quiz_black_belt_question2_option_a".tr()
  },
  {
    "question": "quiz_black_belt_text_question3".tr(),
    "options": [
      'quiz_black_belt_question3_option_a'.tr(),
      'quiz_black_belt_question3_option_b'.tr(),
      'quiz_black_belt_question3_option_c'.tr(),
      'quiz_black_belt_question3_option_d'.tr()
    ],
    "rightanswer": "quiz_black_belt_question3_option_a".tr()
  },
  {
    "question": "quiz_black_belt_text_question4".tr(),
    "options": [
      'quiz_black_belt_question4_option_a'.tr(),
      'quiz_black_belt_question4_option_b'.tr(),
      'quiz_black_belt_question4_option_c'.tr(),
      'quiz_black_belt_question4_option_d'.tr()
    ],
    "rightanswer": "quiz_black_belt_question4_option_a".tr()
  },
  {
    "question": "quiz_black_belt_text_question5".tr(),
    "options": [
      'quiz_black_belt_question5_option_a'.tr(),
      'quiz_black_belt_question5_option_b'.tr(),
      'quiz_black_belt_question5_option_c'.tr(),
      'quiz_black_belt_question5_option_d'.tr()
    ],
    "rightanswer": "quiz_black_belt_question5_option_b".tr()
  },
  {
    "question": "quiz_black_belt_text_question6".tr(),
    "options": [
      'quiz_black_belt_question6_option_a'.tr(),
      'quiz_black_belt_question6_option_b'.tr(),
      'quiz_black_belt_question6_option_c'.tr(),
      'quiz_black_belt_question6_option_d'.tr()
    ],
    "rightanswer": "quiz_black_belt_question6_option_d".tr()
  },
];
