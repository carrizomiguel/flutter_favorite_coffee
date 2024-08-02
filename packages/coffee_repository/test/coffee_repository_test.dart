import 'dart:typed_data';

import 'package:coffee_api/coffee_api.dart';
import 'package:coffee_repository/coffee_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockCoffeeApi extends Mock implements CoffeeApi {}

void main() {
  group('Coffee Repository', () {
    late CoffeeApi api;
    late CoffeeRepository repository;

    final response = ('https://url.com', Uint8List.fromList([0]));

    setUp(() {
      api = MockCoffeeApi();

      when(() => api.getRandomCoffee()).thenAnswer(
        (_) async => response,
      );

      repository = CoffeeRepository(api: api);
    });

    test('constructor returns normally', () {
      expect(
        CoffeeRepository.new,
        returnsNormally,
      );
    });

    group('getRandomCoffee', () {
      test('return CoffeeFailure when api throws an exception', () async {
        when(() => api.getRandomCoffee()).thenThrow(Exception());

        final result = await repository.getRandomCoffee();

        expect(
          result.err().unwrap(),
          equals(CoffeeFailure()),
        );

        verify(api.getRandomCoffee).called(1);
      });

      test(
        'return ConnectionFailure when api throws a SocketException',
        () async {
          when(() => api.getRandomCoffee()).thenThrow(ConnectionException());

          final result = await repository.getRandomCoffee();

          expect(
            result.err().unwrap(),
            equals(ConnectionFailure()),
          );

          verify(api.getRandomCoffee).called(1);
        },
      );

      test('makes correct request', () async {
        await repository.getRandomCoffee();

        verify(api.getRandomCoffee).called(1);
      });
    });
  });
}
