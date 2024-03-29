import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';

abstract class ExternalApiMediaPicturesDatasource {
  Future<List<MediaEntity>> getMediaPicturesList();
}
