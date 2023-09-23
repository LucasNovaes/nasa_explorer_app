import 'package:shared_preferences/shared_preferences.dart';

import '../client/cache_storage_client.dart';

class CacheStorageAdapter implements CacheStorageClient {
  late SharedPreferences _sharedPreferences;
  bool _isInitialized = false;
  @override
  bool get isInitialized => _isInitialized;

  @override
  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _isInitialized = true;
  }

  @override
  Future<void> clear() async {
    if (!_isInitialized) await initialize();
    await _sharedPreferences.clear();
  }

  @override
  Future<void> delete(String key) async {
    if (!_isInitialized) await initialize();
    await _sharedPreferences.remove(key);
  }

  @override
  Future<String?> get(String key) async {
    if (!_isInitialized) await initialize();
    return _sharedPreferences.getString(key);
  }

  @override
  Future<void> save({
    required String key,
    required String value,
  }) async {
    if (!_isInitialized) await initialize();
    await _sharedPreferences.setString(key, value);
  }
}
