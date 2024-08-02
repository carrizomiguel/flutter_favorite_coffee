import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCoffeeRepository extends Mock implements CoffeeRepository {}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    CoffeeRepository? repository,
  }) {
    return pumpWidget(
      RepositoryProvider.value(
        value: repository ?? MockCoffeeRepository(),
        child: MaterialApp(
          home: widget,
        ),
      ),
    );
  }
}
