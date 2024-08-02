import 'package:equatable/equatable.dart';

/// {@template coffee_model}
/// A model containing coffee url image
/// {@endtemplate}
class CoffeeModel extends Equatable {
  /// {@macro coffee_model}
  const CoffeeModel({
    required this.file,
  });

  /// Converts a JSON [Map] into a [CoffeeModel] instance
  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    return CoffeeModel(file: json['file'] as String);
  }

  /// The coffee's image
  final String file;

  @override
  List<Object?> get props => [file];
}
