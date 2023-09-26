import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/entities/mock_media_entity.dart';

class MockMediaRepository extends Mock implements MediaRepository {}

void main() {
  late GetMediaPicturesListUsecase getMediaPicturesListUsecase;
  late MockMediaRepository mockMediaRepository;
  late MediaEntity mockMediaEntity;

  setUp(() {
    mockMediaRepository = MockMediaRepository();
    getMediaPicturesListUsecase = GetMediaPicturesListUsecase(
      repository: mockMediaRepository,
    );
    mockMediaEntity = MockMediaEntity.makeEntity();
  });

  test('Should return a list of MediaEntity from the repository', () async {
    when(() => mockMediaRepository.getMediaPicturesList())
        .thenAnswer((_) async => [mockMediaEntity]);

    final result = await getMediaPicturesListUsecase.call();

    expect(result, [mockMediaEntity]);
  });
}
