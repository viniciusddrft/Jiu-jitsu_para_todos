import 'dart:convert';
import 'dart:isolate';

import 'package:jiu_jitsu_para_todos/src/shared/models/quiz/questions_model.dart';
import 'package:jiu_jitsu_para_todos/src/shared/models/wallpaper/wallpapers_model.dart';
import 'package:jiu_jitsu_para_todos/src/shared/plugins/request_rest/interfaces/service_web_response_interface.dart';

import '../plugins/request_rest/service_web_request.dart';

import 'interface/repository_api_interface.dart';

class RepositoryApi implements RepositoryApiInterface {
  final ServiceWebHttp _serviceWebHttp = ServiceWebHttp();

  @override
  Future<List<QuestionModel>> getQuestions(ApiRequests apiRequests) async {
    final ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(_createIsolateGetQuestions, {
      'sendPort': receivePort.sendPort,
      'apiRequests': apiRequests,
    });

    return (await receivePort.first) as List<QuestionModel>;
  }

  Future<List<QuestionModel>> _createIsolateGetQuestions(
      Map<String, dynamic> data) async {
    final List<QuestionModel> questions = [];

    final ServiceWebResponseInterface response =
        await _serviceWebHttp.get((data['apiRequests'] as ApiRequests).url);

    for (var element in (jsonDecode(response.body)['body'] as List)) {
      questions.add(QuestionModel.fromJson(element));
    }
    Isolate.exit(data['sendPort'], questions);
  }

  @override
  Future<List<WallpaperModel>> getWallpapers() async {
    final ReceivePort receivePort = ReceivePort();

    await Isolate.spawn(_createIsolateGetWallPapers, receivePort.sendPort);

    return (await receivePort.first) as List<WallpaperModel>;
  }

  Future<List<WallpaperModel>> _createIsolateGetWallPapers(
      SendPort sendPort) async {
    final List<WallpaperModel> wallpapers = [];

    final ServiceWebResponseInterface response =
        await _serviceWebHttp.get(ApiRequests.wallpapers.url);

    for (var element in (jsonDecode(response.body)['body'] as List)) {
      wallpapers.add(WallpaperModel.fromJson(element));
    }
    Isolate.exit(sendPort, wallpapers);
  }
}
