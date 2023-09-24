import '../entities/media_entity.dart';
import '../repositories/media_repository.dart';

class SaveMediaPicturesListUsecase {
  final MediaRepository repository;

  SaveMediaPicturesListUsecase({
    required this.repository,
  });

  Future<void> call({required List<MediaEntity> list}) async {
    await repository.saveMediaPicturesList(listData: list);
  }
}
