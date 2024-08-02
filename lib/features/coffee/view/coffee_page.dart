import 'package:flutter/material.dart';
import 'package:very_good_example/features/coffee/coffee.dart';

class CoffeePage extends StatelessWidget {
  const CoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoffeeBackground(
      child: CoffeeCard(),
    );
  }
}
