import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/astronomy_picture_entity.dart';

abstract class AstronomyPictureRepository {
  Future<List<AstronomyPictureEntity>> getPicturesList();
}
