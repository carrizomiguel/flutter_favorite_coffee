import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_example/features/features.dart';

import '../../../helpers/helpers.dart';

class MockSavesBloc extends MockBloc<SavesEvent, SavesState>
    implements SavesBloc {}

void main() {
  const url = 'http://url.com';

  late SavesBloc bloc;

  setUp(() {
    bloc = MockSavesBloc();
    when(() => bloc.state).thenReturn(const SavesState());
  });

  group('Saves List', () {
    testWidgets('renders nothing when empty', (widgetTester) async {
      await widgetTester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const SavesPage(),
        ),
      );

      expect(bloc.state.saves.length, 0);

      final grid = widgetTester.widget<MasonryGridView>(
        find.byType(MasonryGridView),
      );
      expect(grid.childrenDelegate.estimatedChildCount, 0);
    });

    group('when data', () {
      setUp(() {
        when(() => bloc.state).thenReturn(
          SavesState(
            saves: {url: Uint8List.fromList(kTransparentImage)},
          ),
        );
      });

      testWidgets('renders one image', (widgetTester) async {
        await widgetTester.pumpApp(
          BlocProvider.value(
            value: bloc,
            child: const SavesList(),
          ),
        );

        expect(bloc.state.saves.length, 1);

        final grid = widgetTester.widget<MasonryGridView>(
          find.byType(MasonryGridView),
        );
        expect(grid.childrenDelegate.estimatedChildCount, 1);
      });
    });
  });
}
