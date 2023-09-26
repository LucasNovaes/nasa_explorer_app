import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/domain/domain.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/presentation/presentation.dart';

import '../../../../mocks/entities/mock_media_entity.dart';

class MockGetMediaPicturesListUsecase extends Mock
    implements GetMediaPicturesListUsecase {}

class MockSaveMediaPicturesListUsecase extends Mock
    implements SaveMediaPicturesListUsecase {}

void main() {
  late PagePresenter presenter;
  late MediaEntity mediaEntity;
  late DetailPage page;
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
    page = DetailPage(presenter: presenter);
    presenter.init();

    presenter.mediaNotifier.value = mediaEntity;
  });
  testWidgets('DetailPage displays media data', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: page));

    expect(find.text('Estrela de neutrons supermassiva'), findsOneWidget);
    expect(find.text('12-12-2021'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}
