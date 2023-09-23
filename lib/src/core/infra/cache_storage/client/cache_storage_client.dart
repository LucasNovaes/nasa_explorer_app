abstract class CacheStorageClient {
  bool get isInitialized;
  Future<void> initialize();
  Future<void> clear();
  Future<void> delete(String key);
  Future<dynamic> get(String key);
  Future<void> save({
    required String key,
    required String value,
  });
}
