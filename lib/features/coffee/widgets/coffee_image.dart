import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:very_good_example/features/coffee/widgets/shimmer_loader.dart';

class CoffeeImage extends StatelessWidget {
  const CoffeeImage({
    required this.bytes,
    required this.width,
    this.isLoading = false,
    this.borderRadius = 0,
    this.height,
    this.fit,
    super.key,
  });

  final Uint8List? bytes;
  final double width;
  final double borderRadius;
  final bool isLoading;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: switch (isLoading) {
        true => ShimmerLoader(
            width: width,
            height: height ?? 200,
            borderRadius: borderRadius,
          ),
        false => switch (bytes) {
            null => Container(
                width: width,
                height: height ?? 200,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: Icon(
                  Icons.image,
                  color: Colors.grey.shade400,
                ),
              ),
            _ => ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Image.memory(
                  bytes!,
                  width: width,
                  height: height,
                  fit: fit,
                ),
              ),
          },
      },
    );
  }
}
