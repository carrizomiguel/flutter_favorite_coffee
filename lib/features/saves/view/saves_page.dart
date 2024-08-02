import 'package:flutter/material.dart';
import 'package:very_good_example/features/features.dart';

class SavesPage extends StatelessWidget {
  const SavesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: const Text(
          'Saves',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: const SavesList(),
    );
  }
}
