import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {
  MockDio() {
    mockInterceptors();
    mockPost(200);
    mockGet(200);
    mockPut(200);
    mockDelete(200);
  }

  When mockPostCall() => when(() =>
      post(any(), data: any(named: 'data'), options: any(named: 'options')));
  void mockPost(int statusCode, {Map? body = const {'any_key': 'any_value'}}) =>
      mockPostCall().thenAnswer((_) async => Response(
          data: body ?? {},
          statusCode: statusCode,
          requestOptions: RequestOptions(data: {}, path: "/")));
  void mockPostError() => mockPostCall().thenThrow(Exception());

  When mockGetCall() => when(() => get(any(), options: any(named: 'options')));
  void mockGet(int statusCode, {Map body = const {'any_key': 'any_value'}}) =>
      mockGetCall().thenAnswer((_) async => Response(
          data: body,
          statusCode: statusCode,
          requestOptions: RequestOptions(data: {}, path: "/")));
  void mockGetError() => mockGetCall().thenThrow(Exception());

  When mockPutCall() => when(() =>
      put(any(), data: any(named: 'data'), options: any(named: 'options')));
  void mockPut(int statusCode, {Map body = const {'any_key': 'any_value'}}) =>
      mockPutCall().thenAnswer((_) async => Response(
          data: body,
          statusCode: statusCode,
          requestOptions: RequestOptions(data: {}, path: "/")));
  void mockPutError() => mockPutCall().thenThrow(Exception());

  When mockDeleteCall() => when(() =>
      delete(any(), data: any(named: 'data'), options: any(named: 'options')));
  void mockDelete(int statusCode,
          {Map body = const {'any_key': 'any_value'}}) =>
      mockDeleteCall().thenAnswer((_) async => Response(
          data: body,
          statusCode: statusCode,
          requestOptions: RequestOptions(data: {}, path: "/")));
  void mockDeleteError() => mockDeleteCall().thenThrow(Exception());

  When mockFetchCall() => when(() => fetch(any()));
  void mockFetch(Response response) =>
      mockFetchCall().thenAnswer((_) => response);

  When mockInterceptorsCall() => when(() => interceptors);
  void mockInterceptors() => mockInterceptorsCall().thenReturn(Interceptors());
}
