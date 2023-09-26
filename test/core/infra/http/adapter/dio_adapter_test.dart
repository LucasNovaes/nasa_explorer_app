import 'package:dio/dio.dart';
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
    url = 'https://example.com';
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
    test('Should return a list of data when the request is 200', () async {
      dio.mockPost(200);

      final response = await dio.post(url);

      expect(response.data, [1, 2, 3]);
    });
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
    test('Should return a list of data when the request is 200', () async {
      dio.mockGet(200);

      final result = await dio.get(
        url,
      );

      expect(result.data, [1, 2, 3]);
    });

    test('Should throw ServerError if get throws error', () {
      dio.mockGetError();

      final response = sut.request(url: url, method: 'get');

      expect(response, throwsA(HttpError.serverError));
    });
  });

  group('put', () {
    test('Should return a Map of data when the request is 200', () async {
      dio.mockGet(200);

      final response = await dio.put(url);

      expect(response.data, isA<Map<dynamic, dynamic>>());
    });
    test('Should throw BadRequest error if put returns 400', () {
      dio.mockPut(400);

      final response = sut.request(url: url, method: 'put');

      expect(response, throwsA(HttpError.badRequest));
    });

    test('Should throw Unauthorized error if put returns 401', () {
      dio.mockPut(401);

      final response = sut.request(url: url, method: 'put');

      expect(response, throwsA(HttpError.unauthorized));
    });

    test('Should throw NotFound error if put returns 404', () async {
      dio.mockPut(404);

      final response = sut.request(url: url, method: 'put');

      expect(response, throwsA(HttpError.notFound));
    });

    test('Should throw MethodNotAllowed error if put returns 405', () {
      dio.mockPut(405);

      final response = sut.request(url: url, method: 'put');

      expect(response, throwsA(HttpError.methodNotAllowed));
    });

    test('Should throw Conflict error if put returns 409', () {
      dio.mockPut(409);

      final response = sut.request(url: url, method: 'put');

      expect(response, throwsA(HttpError.conflict));
    });

    test('Should throw UnprocessableEntity error if get returns 422', () {
      dio.mockPut(422, body: null);

      final response = sut.request(url: url, method: 'put');

      expect(response, throwsA(HttpError.unprocessableEntity));
    });

    test(
        'Should throw UnprocessableEntity error if get returns 422 with a data',
        () {
      dio.mockPut(422);

      final response = sut.request(url: url, method: 'put');

      expect(response, throwsA({"any_key": "any_value"}));
    });
    test('Should throw UnprocessableEntity error if put returns 500', () {
      dio.mockPut(500, body: null);

      final response = sut.request(url: url, method: 'put');

      expect(response, throwsA(HttpError.serverError));
    });
    test(
        'Should throw UnprocessableEntity error if put returns 500 with a data',
        () {
      dio.mockPut(500);

      final response = sut.request(url: url, method: 'put');

      expect(response, throwsA({"any_key": "any_value"}));
    });

    test('Should return a list empty of data when the request is 204',
        () async {
      dio.mockPut(204);

      final response = await sut.request(url: url, method: 'put');

      expect(response, []);
    });

    test('Should return a list empty of data when the request is 201',
        () async {
      dio.mockPut(201, bodyList: []);

      final response = await sut.request(url: url, method: 'put');

      expect(response, []);
    });
  });

  group('delete', () {
    test('Should return a List of data when the request is 200', () async {
      dio.mockDelete(200);

      final response = await dio.delete(url);

      expect(response.data, [1, 2, 3]);
    });

    test('Should throw Unauthorized error if delete returns 401', () {
      dio.mockDelete(401);

      final response = sut.request(url: url, method: 'delete');

      expect(response, throwsA(HttpError.unauthorized));
    });

    test('Should throw NotFound error if delete returns 404', () {
      dio.mockDelete(404);

      final response = sut.request(url: url, method: 'delete');

      expect(response, throwsA(HttpError.notFound));
    });

    test('Should throw MethodNotAllowed error if delete returns 405', () {
      dio.mockDelete(405);

      final response = sut.request(url: url, method: 'delete');

      expect(response, throwsA(HttpError.methodNotAllowed));
    });
  });
  group('patch', () {
    test('Should return a List of data when the request is 200', () async {
      dio.mockPatch(200);

      final response = await dio.patch(url);

      expect(response.data, {'any_key': 'any_value'});
    });

    test('Should throw ServerError if get throws error', () {
      dio.mockPatchError();

      final response = sut.request(url: url, method: 'patch');

      expect(response, throwsA(HttpError.serverError));
    });
  });
}
