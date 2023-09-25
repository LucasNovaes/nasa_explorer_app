import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_explorer_app/src/core/core.dart';
import 'package:nasa_explorer_app/src/core/failure/failure_type.dart';

void main() {
  group('Failure', () {
    test('two Failures with the same properties should be equal', () {
      final failure1 = Failure('Test Message', type: FailureType.unexpected);
      final failure2 = Failure('Test Message', type: FailureType.unexpected);

      expect(failure1, equals(failure2));
    });

    test('Failure objects with different properties should not be equal', () {
      final failure1 = Failure('Test Message 1', type: FailureType.unexpected);
      final failure2 = Failure('Test Message 2', type: FailureType.unexpected);

      expect(failure1, isNot(equals(failure2)));
    });

    test('Failure objects with different types should not be equal', () {
      final failure1 = Failure('Test Message', type: FailureType.unexpected);
      final failure2 = Failure('Test Message', type: FailureType.accessDenied);

      expect(failure1, isNot(equals(failure2)));
    });

    test('Failure objects with different exceptions should not be equal', () {
      final exception1 = Exception('Exception 1');
      final exception2 = Exception('Exception 2');

      final failure1 = Failure('Test Message', exception: exception1);
      final failure2 = Failure('Test Message', exception: exception2);

      expect(failure1, isNot(equals(failure2)));
    });

    test('Failure objects with null exceptions should be equal', () {
      final failure1 = Failure('Test Message');
      final failure2 = Failure('Test Message');

      expect(failure1, equals(failure2));
    });

    test('Failure objects with different null exceptions should be equal', () {
      final failure1 = Failure('Test Message', exception: null);
      final failure2 = Failure('Test Message', exception: null);

      expect(failure1, equals(failure2));
    });

    test('Failure hashCode should be consistent', () {
      final failure1 = Failure('Test Message', type: FailureType.unexpected);
      final failure2 = Failure('Test Message', type: FailureType.unexpected);

      expect(failure1.hashCode, equals(failure2.hashCode));
    });
  });
}
