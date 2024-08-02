import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:very_good_example/features/features.dart';

import '../../../helpers/helpers.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  late Storage storage;

  setUp(() async {
    storage = MockStorage();
    when<dynamic>(() => storage.read(any())).thenReturn(<String, dynamic>{});
    when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
    when(() => storage.delete(any())).thenAnswer((_) async {});
    when(() => storage.clear()).thenAnswer((_) async {});
    HydratedBloc.storage = storage;
  });

  group('Saves Bloc', () {
    group('SavesToggled', () {
      const url = 'https://url.com';
      final image = Uint8List.fromList(kTransparentImage);

      test('reads from storage once upon initialization', () {
        SavesBloc();
        verify<dynamic>(() => storage.read('SavesBloc')).called(1);
      });

      test('set state from storage value', () async {
        when<dynamic>(() => storage.read(any())).thenReturn({
          'saves': {url: image},
        });
        final bloc = SavesBloc();
        expect(bloc.state, SavesState(saves: {url: image}));
      });

      blocTest<SavesBloc, SavesState>(
        'emits new item in list when saved',
        build: SavesBloc.new,
        act: (bloc) => bloc.add(
          SavesToggled(
            url: url,
            image: image,
          ),
        ),
        seed: () => const SavesState(),
        expect: () => <SavesState>[
          SavesState(saves: {url: image}),
        ],
      );

      blocTest<SavesBloc, SavesState>(
        'emits new item in list when saved',
        build: SavesBloc.new,
        act: (bloc) => bloc.add(
          SavesToggled(
            url: url,
            image: image,
          ),
        ),
        seed: () => SavesState(saves: {url: image}),
        expect: () => const <SavesState>[SavesState()],
      );
    });
  });
}
