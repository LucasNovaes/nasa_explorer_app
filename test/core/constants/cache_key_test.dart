import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_explorer_app/src/core/core.dart';

void main() {
  test('CacheKeys.mediasCacheKey should have the correct value', () {
    expect(CacheKeys.mediasCacheKey, "MEDIA_PICTURES");
  });
}
