import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_example/features/features.dart';

class App extends StatelessWidget {
  const App({
    required CoffeeRepository repository,
    super.key,
  }) : _repository = repository;

  final CoffeeRepository _repository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => _repository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const HomePage(),
    );
  }
}
