import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/entities/mock_media_entity.dart';

class MockMediaRepository extends Mock implements MediaRepository {}

void main() {
  late SaveMediaPicturesListUsecase saveMediaPicturesListUsecase;
  late MockMediaRepository mockMediaRepository;
  late MediaEntity mockMediaEntity;

  setUp(() {
    mockMediaRepository = MockMediaRepository();
    saveMediaPicturesListUsecase = SaveMediaPicturesListUsecase(
      repository: mockMediaRepository,
    );
    mockMediaEntity = MockMediaEntity.makeEntity();
  });

  test('Should call the repository to save the list of MediaEntity', () async {
    final list = [mockMediaEntity];
    when(() => mockMediaRepository.saveMediaPicturesList(listData: list))
        .thenAnswer((_) async {});

    await saveMediaPicturesListUsecase.call(list: list);

    verify(() => mockMediaRepository.saveMediaPicturesList(listData: list));
  });
}
