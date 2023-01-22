import 'package:jiu_jitsu_para_todos/src/shared/models/quiz/questions_model.dart';

import '../../models/wallpaper/wallpapers_model.dart';
import '../../services/request_rest/interfaces/service_web_request_interface.dart';

enum ApiRequests {
  wallpapers('https://jiu-jitsu-para-todos.herokuapp.com/wallpapers'),

  quizEnglishWhiteBelt(
      'https://jiu-jitsu-para-todos.herokuapp.com/quiz/english/whitebelt'),
  quizEnglishBlueBelt(
      'https://jiu-jitsu-para-todos.herokuapp.com/quiz/english/bluebelt'),
  quizEnglishBlack(
      'https://jiu-jitsu-para-todos.herokuapp.com/quiz/english/blackbelt'),
  quizPortugueseWhiteBelt(
      'https://jiu-jitsu-para-todos.herokuapp.com/quiz/portuguese/whitebelt'),
  quizPortugueseBlueBelt(
      'https://jiu-jitsu-para-todos.herokuapp.com/quiz/portuguese/bluebelt'),
  quizPortugueseBlackBelt(
      'https://jiu-jitsu-para-todos.herokuapp.com/quiz/portuguese/blackbelt');

  const ApiRequests(this.url);
  final String url;
}

abstract class RepositoryApiInterface {
  abstract final ServiceWebRequestInterface serviceWebRequestInterface;

  const RepositoryApiInterface();

  Future<List<QuestionModel>> getQuestions(ApiRequests apiRequests);

  Future<List<WallpaperModel>> getWallpapers();
}
