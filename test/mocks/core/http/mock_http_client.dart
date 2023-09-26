import 'package:mocktail/mocktail.dart';
import 'package:nasa_explorer_app/src/core/core.dart';

class MockHttpClient extends Mock implements HttpClient {
  When mockRequestCall() => when(() => request(
      url: any(named: 'url'),
      method: any(named: 'method'),
      body: any(named: 'body'),
      headers: any(named: 'headers')));
  void mockRequest(dynamic data) =>
      mockRequestCall().thenAnswer((_) async => await data);
  void mockRequestError(HttpError error) => mockRequestCall().thenThrow(error);
}
