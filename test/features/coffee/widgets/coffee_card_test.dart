import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_example/features/features.dart';

import '../../../helpers/helpers.dart';

class MockCoffeeBloc extends MockBloc<CoffeeEvent, CoffeeState>
    implements CoffeeBloc {}

class MockSavesBloc extends MockBloc<SavesEvent, SavesState>
    implements SavesBloc {}

void main() {
  late CoffeeBloc coffeeBloc;
  late SavesBloc savesBloc;

  setUp(() {
    coffeeBloc = MockCoffeeBloc();
    when(() => coffeeBloc.state).thenReturn(const CoffeeState());

    savesBloc = MockSavesBloc();
    when(() => savesBloc.state).thenReturn(const SavesState());
  });

  group('Coffee Card', () {
    testWidgets('request a new coffee image', (widgetTester) async {
      await widgetTester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: savesBloc),
            BlocProvider.value(value: coffeeBloc),
          ],
          child: const Scaffold(body: CoffeeCard()),
        ),
      );

      final button = find.byKey(const Key('new_coffee_button'));
      expect(button, findsOneWidget);

      await widgetTester.tap(button);

      verify(() => coffeeBloc.add(CoffeeRequested()));
    });
  });
}
