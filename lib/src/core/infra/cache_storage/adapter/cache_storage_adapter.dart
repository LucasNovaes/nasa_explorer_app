import 'package:shared_preferences/shared_preferences.dart';

import '../client/cache_storage_client.dart';

class CacheStorageAdapter implements CacheStorageClient {
  final SharedPreferences sharedPreferences;

  CacheStorageAdapter({required this.sharedPreferences});

  @override
  Future<void> clear() async {
    await sharedPreferences.clear();
  }

  @override
  Future<void> delete(String key) async {
    await sharedPreferences.remove(key);
  }

  @override
  Future<List<String>?> getList(String key) async {
    return sharedPreferences.getStringList(key);
  }

  @override
  Future<void> saveList({
    required String key,
    required List<String> value,
  }) async {
    await sharedPreferences.setStringList(key, value);
  }
}
