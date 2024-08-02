import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:coffee_api/src/models/coffee_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

/// Thrown when an error occurs while there is no connection
class ConnectionException implements Exception {}

/// {@template coffee_api}
/// A Dart Api Client for the Coffee API
/// {@endtemplate}
class CoffeeApi {
  /// {@macro coffee_api}
  CoffeeApi({
    http.Client? httpClient,
  }) : _httpClient = httpClient ?? http.Client();

  /// The host URL used for all API requests.
  ///
  /// Only exposed for testing purposes. Do not use directly.
  @visibleForTesting
  static const authority = 'coffee.alexflipnote.dev';

  final http.Client _httpClient;

  /// Fetches a random coffee image.
  ///
  /// REST call: `GET /random`
  Future<(String, Uint8List)> getRandomCoffee() async {
    try {
      final uri = Uri.https(authority, '/random.json');
      final response = await _httpClient.get(uri);
      final model = CoffeeModel.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );

      final image = await _httpClient.get(Uri.parse(model.file));

      return (model.file, image.bodyBytes);
    } on SocketException {
      throw ConnectionException();
    } catch (_) {
      rethrow;
    }
  }
}
