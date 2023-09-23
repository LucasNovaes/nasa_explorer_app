import '../entities/media_entity.dart';
import '../repositories/media_repository.dart';

class GetMediaPicturesListUsecase {
  final MediaRepository repository;

  GetMediaPicturesListUsecase({
    required this.repository,
  });

  Future<List<MediaEntity>> call() async {
    return await repository.getMediaPicturesList();
  }
}
