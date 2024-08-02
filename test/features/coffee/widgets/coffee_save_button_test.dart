import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_example/features/features.dart';

import '../../../helpers/helpers.dart';

class MockSavesBloc extends MockBloc<SavesEvent, SavesState>
    implements SavesBloc {}

void main() {
  late SavesBloc savesBloc;

  setUp(() {
    savesBloc = MockSavesBloc();
    when(() => savesBloc.state).thenReturn(const SavesState());
  });

  group('Coffee Save Button', () {
    testWidgets('save when image is valid', (widgetTester) async {
      const url = 'https://url.com';
      final image = Uint8List.fromList(kTransparentImage);
      await widgetTester.pumpApp(
        BlocProvider.value(
          value: savesBloc,
          child: Scaffold(
            body: CoffeeSaveButton(
              url: url,
              image: image,
            ),
          ),
        ),
      );

      final button = find.byKey(const Key('toggle_save_button'));
      await widgetTester.tap(button);

      verify(() => savesBloc.add(SavesToggled(url: url, image: image)));
    });

    testWidgets('do nothin when no image', (widgetTester) async {
      const url = 'https://url.com';
      const Uint8List? image = null;

      await widgetTester.pumpApp(
        BlocProvider.value(
          value: savesBloc,
          child: const Scaffold(
            body: CoffeeSaveButton(
              url: url,
              image: image,
            ),
          ),
        ),
      );

      final button = find.byKey(const Key('toggle_save_button'));
      await widgetTester.tap(button);

      verifyNever(
        () => savesBloc.add(
          SavesToggled(
            url: url,
            image: Uint8List.fromList(kTransparentImage),
          ),
        ),
      );
    });
  });
}
