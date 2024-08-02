import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_example/features/features.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('Saves State', () {
    test('Supports value comparisons', () {
      expect(
        const SavesState(),
        const SavesState(),
      );
    });

    test('Returns same object when no properties are passed', () {
      expect(
        const SavesState().copyWith(),
        const SavesState(),
      );
    });

    test('Returns object with updated model when model is passed', () {
      expect(
        const SavesState().copyWith(
          saves: {
            'https://url.com': Uint8List.fromList(kTransparentImage),
          },
        ),
        SavesState(
          saves: {
            'https://url.com': Uint8List.fromList(kTransparentImage),
          },
        ),
      );
    });
  });
}
