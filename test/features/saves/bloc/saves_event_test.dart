import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_example/features/features.dart';

import '../../../helpers/helpers.dart';

void main() {
  const url = 'https://url.com';
  final image = Uint8List.fromList(kTransparentImage);

  group('Saves Event', () {
    group('Saves Requested', () {
      test('Supports value comparisons', () {
        expect(
          SavesToggled(url: url, image: image),
          equals(SavesToggled(url: url, image: image)),
        );
      });

      test('Supports value comparisons', () {
        expect(
          SavesToggled(url: url, image: image).props,
          equals(<Object?>[url, image]),
        );
      });
    });
  });
}
