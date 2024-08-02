import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_example/features/features.dart';

void main() {
  group('Coffee State', () {
    test('Supports value comparisons', () {
      expect(
        const CoffeeState(),
        const CoffeeState(),
      );
    });

    test('Returns same object when no properties are passed', () {
      expect(
        const CoffeeState().copyWith(),
        const CoffeeState(),
      );
    });

    test('Returns object with updated model when model is passed', () {
      expect(
        const CoffeeState().copyWith(status: CoffeeStatus.success),
        const CoffeeState(status: CoffeeStatus.success),
      );
    });
  });
}
