import 'package:nasa_explorer_app/src/features/astronomy_pictures/data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/domain.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/utils/connectivity_utils.dart';

import '../../../../mocks/entities/mock_media_entity.dart';

class MockCacheMediaPicturesDatasources extends Mock
    implements CacheMediaPicturesDatasource {}

class MockExternalApiMediaPicturesDatasources extends Mock
    implements ExternalApiMediaPicturesDatasource {}

class MockConnectivity extends Mock implements ConnectivityUtils {}

void main() {
  late MediaRepositoryImpl mediaRepositoryImpl;
  late MockCacheMediaPicturesDatasources mockCacheMediaPicturesDatasources;
  late MockExternalApiMediaPicturesDatasources
      mockExternalApiMediaPicturesDatasources;
  late MediaEntity mockMediaEntity;

  setUp(() async {
    mockCacheMediaPicturesDatasources = MockCacheMediaPicturesDatasources();
    mockExternalApiMediaPicturesDatasources =
        MockExternalApiMediaPicturesDatasources();
    mockMediaEntity = MockMediaEntity.makeEntity();
    mediaRepositoryImpl = MediaRepositoryImpl(
      cacheMediaPicturesDatasources: mockCacheMediaPicturesDatasources,
      externalApiMediaPicturesDatasources:
          mockExternalApiMediaPicturesDatasources,
    );
  });

  test(
      'Should return media pictures list from external API when there is internet connection',
      () async {
    when(() => mockExternalApiMediaPicturesDatasources.getMediaPicturesList())
        .thenAnswer((_) async => [mockMediaEntity]);

    final result =
        await mediaRepositoryImpl.getMediaPicturesList(isConnected: true);

    expect(result, [mockMediaEntity]);
  });

  test(
      'Should return media pictures list from cache when there is no internet connection',
      () async {
    when(() => mockCacheMediaPicturesDatasources.getMediaPicturesList())
        .thenAnswer((_) async => [mockMediaEntity]);

    final result =
        await mediaRepositoryImpl.getMediaPicturesList(isConnected: false);

    expect(result, isA<List<MediaEntity>>());
  });

  test(
      'Should return empty list when there is no internet connection and no data in cache',
      () async {
    when(() => mockCacheMediaPicturesDatasources.getMediaPicturesList())
        .thenAnswer((_) async => []);

    final result = await mediaRepositoryImpl.getMediaPicturesList();

    expect(result, []);
  });

  test('Should save media pictures list to cache', () async {
    final listData = [mockMediaEntity];
    when(() => mockCacheMediaPicturesDatasources.saveMediaPicturesList(
        listData: listData)).thenAnswer((_) async {});

    // Act
    await mediaRepositoryImpl.saveMediaPicturesList(listData: listData);

    verify(() => mockCacheMediaPicturesDatasources.saveMediaPicturesList(
        listData: listData));
  });
}
