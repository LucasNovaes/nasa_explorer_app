import '../../../../../core/core.dart';
import '../../../../../core/failure/failure_type.dart';
import '../../../domain/entities/media_entity.dart';
import '../../models/media_model.dart';
import 'cache_media_pictures_datasource.dart';

class CacheMediaPicturesDatasourceImpl implements CacheMediaPicturesDatasource {
  final CacheStorageClient cacheStorage;

  const CacheMediaPicturesDatasourceImpl({
    required this.cacheStorage,
  });

  @override
  Future<List<MediaEntity>> getMediaPicturesList() async {
    try {
      final response = await cacheStorage.get(CacheKeys.mediasCacheKey);
      final data = List.from(response);

      if (data.isNotEmpty) {
        return data.map((e) => MediaModel.fromMap(e).toEntity()).toList();
      } else {
        throw const Failure("Error when getMediaPicturesList",
            type: FailureType.emptyData);
      }
    } catch (_) {
      rethrow;
    }
  }
}
