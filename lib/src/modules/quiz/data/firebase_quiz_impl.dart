import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/interector/quiz_state.dart';
import '../interector/interfaces/ifirebase_quiz.dart';
import '../interector/question_entity.dart';
import 'adapters/question_adapter.dart';

class FirebaseQuizImpl implements IFirebaseQuiz {
  @override
  Future<QuizState> loadQuestions(
      Difficult difficult, String languageCode) async {
    try {
      final questionsRef = FirebaseFirestore.instance
          .collection(difficult.nameCollection + languageCode)
          .withConverter<QuestionEntity>(
            fromFirestore: (snapshots, _) =>
                QuestionAdapter.fromJson(snapshots.data()!),
            toFirestore: (question, _) => QuestionAdapter.toJson(question),
          );

      final QuerySnapshot querySnapshot = await questionsRef.get();

      final questions = List<QuestionEntity>.from(
          querySnapshot.docs.map((doc) => doc.data()));

      questions.shuffle();
      for (var element in questions) {
        element.options.shuffle();
      }

      return QuizSuccess(questions);
    } catch (e) {
      return const QuizFailed();
    }
  }
}
