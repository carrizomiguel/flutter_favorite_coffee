import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:coffee_api/coffee_api.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late Uri coffeeUri;

  group('Coffee Api', () {
    late http.Client httpClient;
    late CoffeeApi api;

    setUp(() {
      httpClient = MockHttpClient();
      api = CoffeeApi(httpClient: httpClient);
      coffeeUri = Uri.https(CoffeeApi.authority, '/random.json');
    });

    test('constructor returns normally', () {
      expect(
        CoffeeApi.new,
        returnsNormally,
      );
    });

    group('fetch a random coffee', () {
      const url = 'https://url.com';
      final image = Uint8List.fromList([0]);

      setUp(() {
        when(() => httpClient.get(coffeeUri)).thenAnswer(
          (_) async => http.Response(
            jsonEncode({'file': url}),
            200,
          ),
        );

        when(() => httpClient.get(Uri.parse(url))).thenAnswer(
          (_) async => http.Response.bytes(image, 200),
        );
      });

      test('throws ConnectionException when SocketException', () {
        when(() => httpClient.get(coffeeUri)).thenThrow(
          const SocketException(''),
        );

        expect(
          api.getRandomCoffee,
          throwsA(isA<ConnectionException>()),
        );
      });

      test('rethrow when Exception', () {
        when(() => httpClient.get(coffeeUri)).thenThrow(Exception());

        expect(
          api.getRandomCoffee,
          throwsA(isA<Exception>()),
        );
      });

      test('makes correct request', () async {
        await api.getRandomCoffee();

        verify(
          () => httpClient.get(coffeeUri),
        ).called(1);
      });

      test('returns correct url and image', () {
        expect(
          api.getRandomCoffee(),
          completion(equals((url, image))),
        );
      });
    });
  });
}
