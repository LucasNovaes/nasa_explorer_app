import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_explorer_app/src/core/core.dart';

import '../../../../mocks/http/mock_dio.dart';

class OptionsFake extends Fake implements Options {}

class InterceptorFake extends Fake implements Interceptor {}

void main() {
  late MockDio dio;
  late DioAdapter sut;
  late String url;
  late List<Interceptor> interceptors;

  setUp(() {
    interceptors = <Interceptor>[InterceptorFake(), InterceptorFake()];
    dio = MockDio();
    sut = DioAdapter(dio: dio, interceptors: interceptors);
  });

  setUpAll(() {
    url = faker.internet.httpUrl();
    registerFallbackValue(OptionsFake());
  });

  group('shared', () {
    test('Should throw ServerError if invalid method is provided', () async {
      final response = sut.request(url: url, method: 'invalid');

      expect(response, throwsA(HttpError.serverError));
    });

    test('Should add interceptors when they are received', () async {
      expect(dio.interceptors, containsAll(interceptors));
    });
  });

  group('post', () {
    test('Should throw ServerError if post returns 500', () {
      dio.mockPost(500);

      final response = sut.request(url: url, method: 'post');

      expect(response, throwsA(HttpError.serverError));
    });

    test('Should throw ServerError if post throws error', () {
      dio.mockPostError();

      final response = sut.request(url: url, method: 'post');

      expect(response, throwsA(HttpError.serverError));
    });
  });

  group('get', () {
    test('Should throw ServerError if get returns 500', () {
      dio.mockGet(500);

      final response = sut.request(url: url, method: 'get');

      expect(response, throwsA(HttpError.serverError));
    });

    test('Should throw ServerError if get throws error', () {
      dio.mockGetError();

      final response = sut.request(url: url, method: 'get');

      expect(response, throwsA(HttpError.serverError));
    });
  });

  group('put', () {
    test('Should throw BadRequestError if get returns 400', () {
      dio.mockPut(400);

      final response = sut.request(url: url, method: 'put');

      expect(response, throwsA(HttpError.badRequest));
    });

    test('Should throw BadRequestError if get returns 401', () {
      dio.mockPut(401);

      final response = sut.request(url: url, method: 'put');

      expect(response, throwsA(HttpError.unauthorized));
    });

    test('Should throw BadRequestError if get returns 404', () {
      dio.mockPut(404);

      final response = sut.request(url: url, method: 'put');

      expect(response, throwsA(HttpError.notFound));
    });

    test('Should throw BadRequestError if get returns 405', () {
      dio.mockPut(405);

      final response = sut.request(url: url, method: 'put');

      expect(response, throwsA(HttpError.methodNotAllowed));
    });
  });

  group('delete', () {
    test('Should throw BadRequestError if delete returns 400', () {
      dio.mockDelete(400);

      final response = sut.request(url: url, method: 'delete');

      expect(response, throwsA(HttpError.badRequest));
    });

    test('Should throw BadRequestError if delete returns 401', () {
      dio.mockDelete(401);

      final response = sut.request(url: url, method: 'delete');

      expect(response, throwsA(HttpError.unauthorized));
    });

    test('Should throw BadRequestError if delete returns 404', () {
      dio.mockDelete(404);

      final response = sut.request(url: url, method: 'delete');

      expect(response, throwsA(HttpError.notFound));
    });

    test('Should throw BadRequestError if delete returns 405', () {
      dio.mockDelete(405);

      final response = sut.request(url: url, method: 'delete');

      expect(response, throwsA(HttpError.methodNotAllowed));
    });
  });
}
