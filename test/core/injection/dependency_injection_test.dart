import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_explorer_app/src/core/core.dart';

void main() {
  group('DependencyInjection', () {
    test('register and get', () {
      final di = DependencyInjection();
      final exampleObject =
          ExampleObject();

      di.register<ExampleObject>(exampleObject);
      final result = di.get<ExampleObject>();

      expect(result, equals(exampleObject));
    });
  });
}

class ExampleObject {}
