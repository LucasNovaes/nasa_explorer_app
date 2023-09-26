import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nasa_explorer_app/src/features/astronomy_pictures/utils/connectivity_utils.dart';

class MockConnectivity extends Mock implements ConnectivityUtils {}

void main() {
  late MockConnectivity mockConnectivity;

  setUp(() {
    mockConnectivity = MockConnectivity();
  });

  test('Should return true when there is internet connection', () async {
    when(() => mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => true);

    final result = await mockConnectivity.checkConnectivity();

    expect(result, true);
  });

  test('Should return false when there is no internet connection', () async {
    when(() => mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => false);

    final result = await mockConnectivity.checkConnectivity();

    expect(result, false);
  });
}
