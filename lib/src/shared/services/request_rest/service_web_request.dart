import 'package:http/http.dart' as http;

import 'interfaces/service_web_request_interface.dart';
import 'interfaces/service_web_response_interface.dart';
import 'service_web_response.dart';

class ServiceWebHttp implements ServiceWebRequestInterface {
  const ServiceWebHttp();

  @override
  Future<ServiceWebResponseInterface> get(String url,
      {Map<String, String>? headers}) async {
    final http.Response response =
        await http.get(Uri.parse(url), headers: headers);

    return ServiceWebResponse(
        statusCode: response.statusCode,
        bodyBytes: response.bodyBytes,
        headers: response.headers);
  }
}
