import '../entities/media_entity.dart';

abstract class MediaRepository {
  Future<List<MediaEntity>> getMediaPicturesList();
  Future<void> saveMediaPicturesList({required List<MediaEntity> listData});
}
