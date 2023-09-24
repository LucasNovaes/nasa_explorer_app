import 'dart:convert';

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
      final response =
          await cacheStorage.getList(CacheKeys.mediasCacheKey) ?? [];

      if (response.isNotEmpty) {
        return response
            .map((e) => MediaModel.fromMap(jsonDecode(e)).toEntity())
            .toList();
      } else {
        throw const Failure("Error when getMediaPicturesList",
            type: FailureType.emptyData);
      }
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> saveMediaPicturesList(
      {required List<MediaEntity> listData}) async {
    try {
      final jsonList =
          listData.map((media) => jsonEncode(media.toMap())).toList();
      await cacheStorage.saveList(
          key: CacheKeys.mediasCacheKey, value: jsonList);
    } catch (_) {
      rethrow;
    }
  }
}
