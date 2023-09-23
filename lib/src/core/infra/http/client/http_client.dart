abstract class HttpClient {
  Future<dynamic> request({
    required String url,
    required String method,
    bool userDefaultHeaders = true,
    Map<String, dynamic>? queryParameters,
    Map? body,
    Map? headers,
  });
}
