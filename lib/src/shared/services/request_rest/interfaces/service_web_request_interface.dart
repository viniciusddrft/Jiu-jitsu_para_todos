import 'dart:convert';

import 'service_web_response_interface.dart';

abstract class ServiceWebRequestInterface {
  Future<ServiceWebResponseInterface> get(String url,
      {Map<String, String>? headers});

  Future<ServiceWebResponseInterface> post(String url,
      {Object? body, Map<String, String>? headers, Encoding? encoding});

  Future<ServiceWebResponseInterface> delete(String url,
      {Object? body, Map<String, String>? headers, Encoding? encoding});
}
