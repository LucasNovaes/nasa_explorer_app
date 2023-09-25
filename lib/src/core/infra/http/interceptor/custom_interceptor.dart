import 'package:dio/dio.dart';

import '../../../core.dart';

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final apiKey = {"api_key": EnvironmentConfig.apiKey};
    options.queryParameters.addAll(apiKey);

    return super.onRequest(
      options,
      handler,
    );
  }
}
