import 'dart:io';

abstract class HttpClient {
  Future<HttpResponse> request({
    required String method,
    required String url,
    Map? body,
    Map? headers,
  });
}
