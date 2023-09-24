import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';

abstract class CacheMediaPicturesDatasource {
  Future<List<MediaEntity>> getMediaPicturesList();
  Future<void> saveMediaPicturesList({required List<MediaEntity> listData});
}
