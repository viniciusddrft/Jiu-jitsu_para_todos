import 'dart:convert';
import 'dart:isolate';

import 'package:jiu_jitsu_para_todos/src/shared/models/quiz/questions_model.dart';
import 'package:jiu_jitsu_para_todos/src/shared/models/wallpaper/wallpapers_model.dart';

import '../services/request_rest/interfaces/service_web_request_interface.dart';
import '../services/request_rest/interfaces/service_web_response_interface.dart';
import '../services/request_rest/service_web_request.dart';

import 'interface/repository_api_interface.dart';

class RepositoryApi implements RepositoryApiInterface {
  @override
  final ServiceWebRequestInterface serviceWebRequestInterface =
      const ServiceWebHttp();

  @override
  Future<List<QuestionModel>> getQuestions(ApiRequests apiRequests) async {
    final questions = await Isolate.run(() async {
      final List<QuestionModel> questions = [];

      final ServiceWebResponseInterface response =
          await serviceWebRequestInterface.get(apiRequests.url);

      for (var element
          in (jsonDecode(utf8.decode(response.bodyBytes))['body'] as List)) {
        questions
            .add(QuestionModel.fromJson(Map<String, Object?>.from(element)));
      }
      questions.shuffle();
      for (QuestionModel question in questions) {
        question.options.shuffle();
      }

      return questions;
    });

    return questions;
  }

  @override
  Future<List<WallpaperModel>> getWallpapers() async {
    final wallpapers = await Isolate.run<List<WallpaperModel>>(
      () async {
        final List<WallpaperModel> wallpapers = [];

        final ServiceWebResponseInterface response =
            await serviceWebRequestInterface.get(ApiRequests.wallpapers.url);

        for (var element
            in (jsonDecode(utf8.decode(response.bodyBytes))['body'] as List)) {
          wallpapers
              .add(WallpaperModel.fromJson(Map<String, String>.from(element)));
        }
        return wallpapers;
      },
    );
    return wallpapers;
  }
}
