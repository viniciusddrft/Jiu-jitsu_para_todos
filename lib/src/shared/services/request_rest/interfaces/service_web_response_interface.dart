import 'dart:typed_data';

abstract interface class ServiceWebResponseInterface {
  final Uint8List bodyBytes;
  final int statusCode;
  final Map<String, String> headers;

  const ServiceWebResponseInterface(
      this.bodyBytes, this.statusCode, this.headers);
}
