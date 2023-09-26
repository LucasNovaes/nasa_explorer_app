import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {
  MockDio() {
    mockInterceptors();
    mockPost(200);
    mockGet(200);
    mockPut(200);
    mockDelete(200);
    mockPatch(200);
  }

  Response response(int statusCode) => Response(
      statusCode: statusCode,
      data: [1, 2, 3],
      requestOptions: RequestOptions(path: "/"));

  When mockPostCall() => when(() =>
      post(any(), data: any(named: 'data'), options: any(named: 'options')));
  void mockPost(int statusCode) =>
      mockPostCall().thenAnswer((_) async => response(statusCode));
  void mockPostError() => mockPostCall().thenThrow(Exception());

  When mockGetCall() => when(() => get(any()));
  void mockGet(int statusCode) =>
      mockGetCall().thenAnswer((_) async => response(statusCode));
  void mockGetError() => mockGetCall().thenThrow(Exception());

  When mockPutCall() => when(() =>
      put(any(), data: any(named: 'data'), options: any(named: 'options')));
  void mockPut(int statusCode,
          {List? bodyList, Map? body = const {'any_key': 'any_value'}}) =>
      mockPutCall().thenAnswer((_) async => Response(
          data: bodyList ?? body,
          statusCode: statusCode,
          requestOptions: RequestOptions(data: {}, path: "/")));
  void mockPutError() => mockPutCall().thenThrow(Exception());

  When mockDeleteCall() => when(() =>
      delete(any(), data: any(named: 'data'), options: any(named: 'options')));
  void mockDelete(int statusCode) =>
      mockDeleteCall().thenAnswer((_) async => response(statusCode));
  void mockDeleteError() => mockDeleteCall().thenThrow(Exception());

  When mockFetchCall() => when(() => fetch(any()));
  void mockFetch(Response response) =>
      mockFetchCall().thenAnswer((_) => response);

  When mockPatchCall() => when(() =>
      patch(any(), data: any(named: 'data'), options: any(named: 'options')));
  void mockPatch(int statusCode,
          {List? bodyList, Map? body = const {'any_key': 'any_value'}}) =>
      mockPatchCall().thenAnswer((_) async => Response(
          data: bodyList ?? body,
          statusCode: statusCode,
          requestOptions: RequestOptions(data: {}, path: "/")));
  void mockPatchError() => mockPatchCall().thenThrow(Exception());

  When mockInterceptorsCall() => when(() => interceptors);
  void mockInterceptors() => mockInterceptorsCall().thenReturn(Interceptors());
}
