import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/repositories/media_repository.dart';

import '../../utils/check_connectivity.dart';
import '../datasources/datasources.dart';

class MediaRepositoryImpl implements MediaRepository {
  final CacheMediaPicturesDatasource cacheMediaPicturesDatasources;
  final ExternalApiMediaPicturesDatasource externalApiMediaPicturesDatasources;

  const MediaRepositoryImpl({
    required this.cacheMediaPicturesDatasources,
    required this.externalApiMediaPicturesDatasources,
  });

  @override
  Future<List<MediaEntity>> getMediaPicturesList() async {
    final isConnected = await checkConnectivity();
    return isConnected
        ? await externalApiMediaPicturesDatasources.getMediaPicturesList()
        : await cacheMediaPicturesDatasources.getMediaPicturesList();
  }

  @override
  Future<void> saveMediaPicturesList(
      {required List<MediaEntity> listData}) async {
    await cacheMediaPicturesDatasources.saveMediaPicturesList(
        listData: listData);
  }
}
