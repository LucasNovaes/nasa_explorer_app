import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/entities/media_entity.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/usecases/get_media_pictures_list_usecase.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/usecases/save_media_pictures_list_usecase.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/presentation.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/states/page_state.dart';

import '../../../../mocks/domain/entities/mock_media_entity.dart';
import '../../../../mocks/domain/usecases/mock_get_media_pictures_list_usecase.dart';
import '../../../../mocks/domain/usecases/mock_save_media_pictures_list_usecase.dart';

void main() {
  group('PagePresenter Tests', () {
    late PagePresenter presenter;
    late GetMediaPicturesListUsecase mockGetMediaPicturesListUsecase;
    late SaveMediaPicturesListUsecase mockSaveMediaPicturesListUsecase;
    late MediaEntity mockMediaEntity;

    setUp(() {
      mockGetMediaPicturesListUsecase = MockGetMediaPicturesListUsecase();
      mockSaveMediaPicturesListUsecase = MockSaveMediaPicturesListUsecase();
      presenter = PagePresenter(
        getMediaPicturesListUsecase: mockGetMediaPicturesListUsecase,
        saveMediaPicturesListUsecase: mockSaveMediaPicturesListUsecase,
      );
      mockMediaEntity = MockMediaEntity.makeEntity();
      presenter.init();
    });

    test('Initial state should be PageStateInitial', () {
      expect(presenter.pageState.value, isA<PageStateInitial>());
    });

    test('getMediaList should load mediaList and change state', () async {
      final mockMediaList = [
        mockMediaEntity,
        mockMediaEntity,
      ];
      when(() => mockGetMediaPicturesListUsecase())
          .thenAnswer((_) async => mockMediaList);
      when(() => mockSaveMediaPicturesListUsecase(list: mockMediaList))
          .thenAnswer((_) async {});

      await presenter.getMediaList();

      expect(presenter.pageState.value, isA<PageStateSuccess>());
      expect(presenter.mediaList.value, mockMediaList);
    });

    test('getMediaList should handle error', () async {
      when(() => mockGetMediaPicturesListUsecase()).thenThrow(Exception());

      expect(() => presenter.getMediaList(), throwsException);

      expect(presenter.pageState.value, isA<PageStateError>());
    });
    test('Search should filter mediaList correctly', () async {
      final mockMediaList = [
        mockMediaEntity,
        mockMediaEntity,
      ];
      presenter.mediaList.value = mockMediaList;

      await presenter.search('Estrela de neutrons');

      expect(presenter.filteredMediaList.first, mockMediaList[0]);
    });
  });
}
