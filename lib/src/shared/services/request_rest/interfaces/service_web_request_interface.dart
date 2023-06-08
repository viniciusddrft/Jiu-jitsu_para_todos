import 'service_web_response_interface.dart';

abstract interface class ServiceWebRequestInterface {
  Future<ServiceWebResponseInterface> get(String url,
      {Map<String, String>? headers});
}
