import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_example/features/features.dart';

class CoffeeBackground extends StatelessWidget {
  const CoffeeBackground({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Stack(
      alignment: Alignment.center,
      children: [
        BlocBuilder<CoffeeBloc, CoffeeState>(
          builder: (context, state) {
            final currentCoffee = state.currentCoffee;
            final isLoading = state.status.isLoading;

            return Stack(
              children: [
                ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 20,
                    sigmaY: 20,
                  ),
                  child: CoffeeImage(
                    bytes: currentCoffee,
                    width: width - 30,
                    height: height,
                    fit: BoxFit.fitHeight,
                    isLoading: isLoading,
                  ),
                ),
                SizedBox.expand(
                  child: ColoredBox(
                    color: Colors.black.withOpacity(.5),
                  ),
                ),
              ],
            );
          },
        ),
        child,
      ],
    );
  }
}
