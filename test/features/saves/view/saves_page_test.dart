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
  late SavesBloc bloc;

  setUp(() {
    bloc = MockSavesBloc();
    when(() => bloc.state).thenReturn(const SavesState());
  });

  group('Saves Page', () {
    testWidgets('renders Scaffold', (widgetTester) async {
      await widgetTester.pumpApp(
        BlocProvider.value(
          value: bloc,
          child: const SavesPage(),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
    });
  });
}
