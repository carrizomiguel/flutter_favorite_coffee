import 'package:bloc_test/bloc_test.dart';
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

  group('Saves Page', () {
    testWidgets('renders Scaffold', (widgetTester) async {
      await widgetTester.pumpApp(
        MultiBlocProvider(
          providers: [
            BlocProvider.value(value: savesBloc),
            BlocProvider.value(value: coffeeBloc),
          ],
          child: const CoffeePage(),
        ),
      );

      expect(find.byType(CoffeeBackground), findsOneWidget);
    });
  });
}
