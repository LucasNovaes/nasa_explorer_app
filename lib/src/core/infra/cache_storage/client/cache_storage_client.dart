abstract class CacheStorageClient {
  bool get isInitialized;
  Future<void> initialize();
  Future<void> clear();
  Future<void> delete(String key);
  Future<List<String>?> getList(String key);
  Future<void> saveList({
    required String key,
    required List<String> value,
  });
}
