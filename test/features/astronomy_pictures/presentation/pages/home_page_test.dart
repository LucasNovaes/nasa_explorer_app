import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/domain.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/pages/widgets/base_page.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/presentation.dart';

import '../../../../mocks/entities/mock_media_entity.dart';

class MockGetMediaPicturesListUsecase extends Mock
    implements GetMediaPicturesListUsecase {}

class MockSaveMediaPicturesListUsecase extends Mock
    implements SaveMediaPicturesListUsecase {}

void main() {
  late PagePresenter presenter;
  late MediaEntity mediaEntity;
  late HomePage page;
  late MockGetMediaPicturesListUsecase mockGetMediaPicturesListUsecase;
  late MockSaveMediaPicturesListUsecase mockSaveMediaPicturesListUsecase;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mediaEntity = MockMediaEntity.makeEntity();
    mockGetMediaPicturesListUsecase = MockGetMediaPicturesListUsecase();
    mockSaveMediaPicturesListUsecase = MockSaveMediaPicturesListUsecase();
    presenter = PagePresenter(
        getMediaPicturesListUsecase: mockGetMediaPicturesListUsecase,
        saveMediaPicturesListUsecase: mockSaveMediaPicturesListUsecase);
    page = HomePage(presenter: presenter);

    presenter.init();

    presenter.mediaList.value = [mediaEntity];
    when(() => mockGetMediaPicturesListUsecase.call())
        .thenAnswer((_) async => [mediaEntity]);
    when(() => mockSaveMediaPicturesListUsecase.call(list: [mediaEntity]))
        .thenAnswer((_) async => [mediaEntity]);
  });

  group('HomePageTest', () {
    testWidgets('Should render the page correctly', (tester) async {
      await tester.pumpWidget(MaterialApp(home: page));

      expect(find.byType(BasePage), findsOneWidget);
      expect(find.byType(SearchBar), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Should call the presenter when the refresh button is pressed',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: page));
      await tester.tap(find.byIcon(Icons.refresh));
    });

    testWidgets('Should call the presenter when the search bar text is changed',
        (tester) async {
      await tester.pumpWidget(MaterialApp(home: page));
      await tester.enterText(find.byType(TextField), 'supermassiva');
    });
  });
}
