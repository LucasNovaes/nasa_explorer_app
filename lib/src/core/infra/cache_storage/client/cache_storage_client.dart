abstract class CacheStorageClient {
  Future<void> clear();
  Future<void> delete(String key);
  Future<List<String>?> getList(String key);
  Future<void> saveList({
    required String key,
    required List<String> value,
  });
}
