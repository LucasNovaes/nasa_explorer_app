import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/repositories/media_repository.dart';

import '../datasources/datasources.dart'
    show CacheMediaPicturesDatasource, ExternalApiMediaPicturesDatasource;

class MediaRepositoryImpl implements MediaRepository {
  final CacheMediaPicturesDatasource cacheMediaPicturesDatasources;
  final ExternalApiMediaPicturesDatasource externalApiMediaPicturesDatasources;

  const MediaRepositoryImpl({
    required this.cacheMediaPicturesDatasources,
    required this.externalApiMediaPicturesDatasources,
  });

  @override
  Future<List<MediaEntity>> getMediaPicturesList() async {
    final isConnected = await _checkConnectivity();
    return isConnected
        ? await externalApiMediaPicturesDatasources.getMediaPicturesList()
        : await cacheMediaPicturesDatasources.getMediaPicturesList();
  }

  Future<bool> _checkConnectivity() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
}
