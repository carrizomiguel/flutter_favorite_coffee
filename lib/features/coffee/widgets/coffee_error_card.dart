import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_example/features/features.dart';

class CoffeeErrorCard extends StatelessWidget {
  const CoffeeErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CoffeeBloc, CoffeeState>(
      builder: (context, state) {
        final status = state.status;
        final isNoSuccess = status.isNoSuccess;

        return AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: Container(
            width: double.infinity,
            height: isNoSuccess ? null : 0,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              switch (status) {
                CoffeeStatus.error => 'An error occured!',
                CoffeeStatus.noConnection => 'There is no internet!',
                _ => '',
              },
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
