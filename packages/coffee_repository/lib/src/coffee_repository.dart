import 'dart:typed_data';

import 'package:coffee_api/coffee_api.dart';
import 'package:equatable/equatable.dart';
// import 'package:equatable/equatable.dart';
import 'package:oxidized/oxidized.dart';

/// Base class for failures
abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Return when an error occurs while fetching a random coffee
class CoffeeFailure extends Failure {}

/// Return when an error occurs while no connection found
class ConnectionFailure extends Failure {}

/// {@template coffee_repository}
/// A Dart Package to manage the Coffee Domain
/// {@endtemplate}
class CoffeeRepository {
  /// {@macro coffee_repository}
  CoffeeRepository({
    CoffeeApi? api,
  }) : _api = api ?? CoffeeApi();

  final CoffeeApi _api;

  /// Returns a random coffee image url
  ///
  /// Throws a [Failure] if an error occurs.
  Future<Result<(String, Uint8List), Failure>> getRandomCoffee() async {
    try {
      final response = await _api.getRandomCoffee();

      return Result.ok(response);
    } on ConnectionException {
      return Result.err(ConnectionFailure());
    } catch (e) {
      return Result.err(CoffeeFailure());
    }
  }
}
