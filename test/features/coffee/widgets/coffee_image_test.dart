import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:very_good_example/features/features.dart';

import '../../../helpers/helpers.dart';

void main() {
  group('Coffee Image', () {
    testWidgets('render a valid image', (widgetTester) async {
      await widgetTester.pumpApp(
        Scaffold(
          body: CoffeeImage(
            bytes: Uint8List.fromList(kTransparentImage),
            width: 300,
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });
  });
}
