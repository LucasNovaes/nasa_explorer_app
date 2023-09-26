import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_explorer_app/src/core/core.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../mocks/entities/mock_media_entity.dart';

void main() {
  late CacheStorageClient cacheStorage;
  late MediaEntity mockMediaEntity;
  late String key;
  late List<String> listEncode;

  setUp(() async {
    mockMediaEntity = MockMediaEntity.makeEntity();
    key = 'test_key';
    listEncode =
        [mockMediaEntity].map((media) => jsonEncode(media.toMap())).toList();

    SharedPreferences.setMockInitialValues({
      key: jsonEncode(listEncode),
    });

    cacheStorage = CacheStorageAdapter();
    cacheStorage.saveList(key: key, value: listEncode);
  });

  test('getList should call SharedPreferences.getStringList', () async {
    final result = await cacheStorage.getList(key);
    expect(result, isA<List<String>>());
  });

  test('saveList should call SharedPreferences.setStringList', () async {
    await cacheStorage.saveList(key: key, value: listEncode);
    final result = await cacheStorage.getList(key);
    expect(result, isA<List>());
  });
  test('clear should call SharedPreferences.clear', () async {
    await cacheStorage.clear();
    expect(await cacheStorage.getList(key), null);
  });

  test('delete should call SharedPreferences.remove', () async {
    await cacheStorage.delete(key);
    expect(await cacheStorage.getList(key), null);
  });
}
