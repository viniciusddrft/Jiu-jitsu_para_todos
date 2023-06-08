import 'package:jiu_jitsu_para_todos/src/shared/models/quiz/questions_model.dart';

import '../../models/wallpaper/wallpapers_model.dart';
import '../../services/request_rest/interfaces/service_web_request_interface.dart';

enum ApiRequests {
  wallpapers('https://web-production-5160.up.railway.app/wallpapers'),
  quizEnglishWhiteBelt(
      'https://web-production-5160.up.railway.app/quiz/english/whitebelt'),
  quizEnglishBlueBelt(
      'https://web-production-5160.up.railway.app/quiz/english/bluebelt'),
  quizEnglishBlack(
      'https://web-production-5160.up.railway.app/quiz/english/blackbelt'),
  quizPortugueseWhiteBelt(
      'https://web-production-5160.up.railway.app/quiz/portuguese/whitebelt'),
  quizPortugueseBlueBelt(
      'https://web-production-5160.up.railway.app/quiz/portuguese/bluebelt'),
  quizPortugueseBlackBelt(
      'https://web-production-5160.up.railway.app/quiz/portuguese/blackbelt');

  const ApiRequests(this.url);
  final String url;
}

abstract interface class RepositoryApiInterface {
  abstract final ServiceWebRequestInterface serviceWebRequestInterface;

  const RepositoryApiInterface();

  Future<List<QuestionModel>> getQuestions(ApiRequests apiRequests);

  Future<List<WallpaperModel>> getWallpapers();
}
