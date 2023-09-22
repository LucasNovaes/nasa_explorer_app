// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/astronomy_picture_entity.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/repositories/astronomy_picture_repository.dart';

class GetAstronomyPicturesListUsecase {
  final AstronomyPictureRepository repository;

  GetAstronomyPicturesListUsecase({
    required this.repository,
  });

  Future<List<AstronomyPictureEntity>> call() async {
    return await repository.getPicturesList();
  }
}
