import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_explorer_app/src/core/core.dart';
import 'package:dio/dio.dart';

void main() {
  test('Should add API key to query parameters', () async {
    // Arrange
    final customInterceptor = CustomInterceptor();
    final options = RequestOptions(
      path: '/',
    );

    // Act
    customInterceptor.onRequest(
      options,
      RequestInterceptorHandler(),
    );

    // Assert
    expect(options.queryParameters['api_key'], EnvironmentConfig.apiKey);
  });
}
