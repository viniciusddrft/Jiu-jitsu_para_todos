import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _Client extends Mock implements HttpClient {}

class _Request extends Mock implements HttpClientRequest {}

class _Headers extends Mock implements HttpHeaders {}

class _Response extends Mock implements HttpClientResponse {}

class _Overrides extends HttpOverrides {
  final bytes = base64Decode(
      'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO+jRZkAAAAASUVORK5CYII=');
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = _Client();
    when(() => client.getUrl(any())).thenAnswer((_) async {
      final request = _Request();
      when(() => request.headers).thenReturn(_Headers());
      when(() => request.close()).thenAnswer((_) async {
        final response = _Response();
        when(() => response.statusCode).thenReturn(200);
        when(() => response.contentLength).thenReturn(bytes.length);
        when(() => response.compressionState)
            .thenReturn(HttpClientResponseCompressionState.notCompressed);
        when(() => response.listen(any(),
                onError: any(named: 'onError'),
                onDone: any(named: 'onDone'),
                cancelOnError: any(named: 'cancelOnError')))
            .thenAnswer((invocation) => Stream<List<int>>.value(bytes).listen(
                invocation.positionalArguments.first as void Function(
                    List<int>)?,
                onError: invocation.namedArguments[#onError],
                onDone: invocation.namedArguments[#onDone] as void Function()?,
                cancelOnError:
                    invocation.namedArguments[#cancelOnError] as bool?));
        return response;
      });
      return request;
    });
    return client;
  }
}

void mockNetworkImages() {
  registerFallbackValue(Uri.parse('https://example.com'));
  final original = HttpOverrides.current;
  HttpOverrides.global = _Overrides();
  addTearDown(() => HttpOverrides.global = original);
}
