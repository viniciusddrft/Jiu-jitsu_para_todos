abstract class ServiceWebResponseInterface {
  final String body;
  final int statusCode;
  final Map<String, String> headers;

  ServiceWebResponseInterface(this.body, this.statusCode, this.headers);
}
