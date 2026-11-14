import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/data/adapters/answer_adapter.dart';
import 'package:jiu_jitsu_para_todos/src/modules/quiz/data/adapters/question_adapter.dart';
import 'package:jiu_jitsu_para_todos/src/modules/wallpapers/data/adapters/wallpapers_adapter.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/local_storage/local_storage_shared_preferrence.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('respostas e perguntas preservam dados em JSON serializável', () {
    for (final correct in [true, false]) {
      final json = {'text': 'Guarda', 'isCorrect': correct};
      final answer = AnswerAdapter.fromJson(json);
      expect(answer.text, 'Guarda');
      expect(answer.isCorrect, correct);
      expect(AnswerAdapter.toJson(answer), json);
    }
    for (final media in [null, 'https://example.com/media']) {
      final json = {
        'question': 'Qual posição?',
        'pathImage': media,
        'pathVideo': media,
        'options': [
          {'text': 'Guarda', 'isCorrect': true},
          {'text': 'Outra', 'isCorrect': false}
        ],
      };
      final question = QuestionAdapter.fromJson(json);
      expect(question.question, 'Qual posição?');
      expect(question.pathImage, media);
      expect(question.pathVideo, media);
      expect(question.options.map((a) => a.isCorrect), [true, false]);
      expect(jsonDecode(jsonEncode(QuestionAdapter.toJson(question))), json);
    }
  });
  test('wallpaper preserva URL na conversão', () {
    const json = {'url': 'https://example.com/image.png'};
    final wallpaper = WallpaperAdapter.fromJson(json);
    expect(wallpaper.url, json['url']);
    expect(WallpaperAdapter.toJson(wallpaper), json);
  });
  test(
      'armazenamento persiste inteiros e strings, retorna ausente e remove chave',
      () async {
    SharedPreferences.setMockInitialValues({});
    final storage = LocalStorageSharedPreferrence();
    expect(identical(storage, LocalStorageSharedPreferrence()), isTrue);
    expect(await storage.getValue<String>('missing'), isNull);
    storage.saveValue('locale', 'pt_BR');
    storage.saveValue('count', 3);
    await Future<void>.delayed(Duration.zero);
    expect(await storage.getValue<String>('locale'), 'pt_BR');
    expect(await storage.getValue<int>('count'), 3);
    storage.remove('locale');
    await Future<void>.delayed(Duration.zero);
    expect(await storage.getValue<String>('locale'), isNull);
  });
}
