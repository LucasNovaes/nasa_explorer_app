import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/data/data.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';

import '../../../../../mocks/core/http/mock_http_client.dart';

void main() {
  test('getMediaPicturesList should return a list of MediaEntity', () async {
    final httpClient = MockHttpClient();
    const baseUrl = 'https://example.com/api';
    final datasource = ExternalApiMediaPicturesDatasourceImpl(
      httpClient: httpClient,
      baseUrl: baseUrl,
    );

    final apiResponse = [
      {
        'title': 'Media 1',
        'date': '2023-09-24',
        'url': 'https://example.com/media1.jpg',
        'explanation': 'Explanation 1',
        'media_type': 'image',
      },
      {
        'title': 'Media 2',
        'date': '2023-09-25',
        'url': 'https://example.com/media2.jpg',
        'explanation': 'Explanation 2',
        'media_type': 'video',
      },
    ];

    when(() => httpClient.request(
          method: 'get',
          url: '$baseUrl/planetary/apod',
          queryParameters: {'count': '10'},
        )).thenAnswer((_) async => apiResponse);

    final result = await datasource.getMediaPicturesList();

    expect(result, isA<List<MediaEntity>>());
    expect(result.length, 2);

    expect(result[0].title, 'Media 1');
    expect(result[0].date, '2023-09-24');
    expect(result[0].url, 'https://example.com/media1.jpg');
    expect(result[0].explanation, 'Explanation 1');
    expect(result[0].mediaType, 'image');

    expect(result[1].title, 'Media 2');
    expect(result[1].date, '2023-09-25');
    expect(result[1].url, 'https://example.com/media2.jpg');
    expect(result[1].explanation, 'Explanation 2');
    expect(result[1].mediaType, 'video');
  });
}
