import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oxidized/oxidized.dart';
import 'package:very_good_example/features/features.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

void main() {
  late CoffeeRepository repository;

  setUp(() {
    repository = MockCoffeeRepository();
  });

  group('Coffee Bloc', () {
    group('CoffeeeRequested', () {
      group('returns ConnectionFailure', () {
        setUp(() {
          when(
            () => repository.getRandomCoffee(),
          ).thenAnswer((_) async => Result.err(ConnectionFailure()));
        });

        blocTest<CoffeeBloc, CoffeeState>(
          'emits CoffeeStatus.noConnection when no internet',
          build: () => CoffeeBloc(repository: repository),
          act: (bloc) => bloc.add(CoffeeRequested()),
          seed: () => const CoffeeState(),
          expect: () => const <CoffeeState>[
            CoffeeState(status: CoffeeStatus.noConnection),
          ],
        );
      });

      group('returns CoffeeFailure', () {
        setUp(() {
          when(
            () => repository.getRandomCoffee(),
          ).thenAnswer((_) async => Result.err(CoffeeFailure()));
        });

        blocTest<CoffeeBloc, CoffeeState>(
          'emits CoffeeStatus.error when request throws Exception',
          build: () => CoffeeBloc(repository: repository),
          act: (bloc) => bloc.add(CoffeeRequested()),
          seed: () => const CoffeeState(),
          expect: () => const <CoffeeState>[
            CoffeeState(status: CoffeeStatus.error),
          ],
        );
      });

      group('returns correctly', () {
        const url = 'https://url.com';
        final image = Uint8List.fromList([0]);

        setUp(() {
          when(
            () => repository.getRandomCoffee(),
          ).thenAnswer((_) async => Result.ok((url, image)));
        });

        blocTest<CoffeeBloc, CoffeeState>(
          'emits CoffeeStatus.success when request is ok',
          build: () => CoffeeBloc(repository: repository),
          act: (bloc) => bloc.add(CoffeeRequested()),
          seed: () => const CoffeeState(),
          expect: () => <CoffeeState>[
            CoffeeState(
              status: CoffeeStatus.success,
              currentCoffee: image,
              currentUrl: url,
            ),
          ],
        );
      });
    });
  });
}
