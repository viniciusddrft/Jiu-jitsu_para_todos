import 'service_web_response_interface.dart';

abstract class ServiceWebRequestInterface {
  const ServiceWebRequestInterface();

  Future<ServiceWebResponseInterface> get(String url,
      {Map<String, String>? headers});
}
