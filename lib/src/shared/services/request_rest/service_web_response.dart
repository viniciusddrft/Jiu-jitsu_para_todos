import 'dart:typed_data';

import 'interfaces/service_web_response_interface.dart';

class ServiceWebResponse implements ServiceWebResponseInterface {
  @override
  final Uint8List bodyBytes;
  @override
  final int statusCode;
  @override
  final Map<String, String> headers;

  const ServiceWebResponse(
      {required this.bodyBytes,
      required this.statusCode,
      required this.headers});
}
