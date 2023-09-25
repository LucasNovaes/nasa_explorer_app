import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:nasa_explorer_app/src/core/core.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/data/data.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/domain.dart';

import '../../../../../mocks/cache_storage/mock_cache_storage.dart';
import '../../../../../mocks/entities/mock_media_entity.dart';

void main() {
  late CacheMediaPicturesDatasourceImpl datasource;
  late CacheStorageClient mockCacheStorage;
  late MediaEntity mockMediaEntity;
  late List<String> listEncode;

  setUp(() {
    mockMediaEntity = MockMediaEntity.makeEntity();
    mockCacheStorage = MockCacheStorage();
    listEncode =
        [mockMediaEntity].map((media) => jsonEncode(media.toMap())).toList();
    datasource =
        CacheMediaPicturesDatasourceImpl(cacheStorage: mockCacheStorage);
  });

  test('getMediaPicturesList should return a list of MediaEntity', () async {
    when(() => mockCacheStorage.saveList(
          key: CacheKeys.mediasCacheKey,
          value: listEncode,
        )).thenAnswer((_) async => {});

    when(() => mockCacheStorage.getList(CacheKeys.mediasCacheKey))
        .thenAnswer((_) async => listEncode);

    final result = await datasource.getMediaPicturesList();

    expect(result, isA<List<MediaEntity>>());
  });

  test('getMediaPicturesList should throw a Failure on empty data', () async {
    when(() => mockCacheStorage.getList(CacheKeys.mediasCacheKey))
        .thenAnswer((_) async => []);

    expect(() => datasource.getMediaPicturesList(), throwsA(isA<Failure>()));

    verify(() => mockCacheStorage.getList(CacheKeys.mediasCacheKey));
  });

  test('saveMediaPicturesList should save a list of MediaEntity', () async {
    when(() => mockCacheStorage.saveList(
          key: CacheKeys.mediasCacheKey,
          value: listEncode,
        )).thenAnswer((_) async => {});

    await datasource.saveMediaPicturesList(listData: [mockMediaEntity]);
  });
}
