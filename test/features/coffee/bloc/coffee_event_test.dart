import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_example/features/features.dart';

void main() {
  group('Coffee Event', () {
    group('Coffee Requested', () {
      test('Supports value comparisons', () {
        expect(CoffeeRequested(), CoffeeRequested());
      });
    });
  });
}
