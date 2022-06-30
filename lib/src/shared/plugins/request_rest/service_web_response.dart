import 'interfaces/service_web_response_interface.dart';

class ServiceWebResponse implements ServiceWebResponseInterface {
  @override
  final String body;
  @override
  final int statusCode;
  @override
  final Map<String, String> headers;

  const ServiceWebResponse(
      {required this.body, required this.statusCode, required this.headers});
}
