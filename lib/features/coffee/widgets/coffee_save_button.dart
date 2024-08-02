import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_example/features/features.dart';

class CoffeeSaveButton extends StatelessWidget {
  const CoffeeSaveButton({
    required this.url,
    required this.image,
    this.size = 35,
    super.key,
  });

  final String url;
  final Uint8List? image;
  final double size;

  @override
  Widget build(BuildContext context) {
    final savesBloc = context.read<SavesBloc>();

    return BlocBuilder<SavesBloc, SavesState>(
      builder: (context, state) {
        final saves = state.saves;

        final isSaved = saves.containsKey(url);

        return IconButton(
          key: const Key('toggle_save_button'),
          onPressed: () {
            if (image == null) return;

            savesBloc.add(
              SavesToggled(
                url: url,
                image: image!,
              ),
            );
          },
          icon: Icon(
            isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
          ),
          iconSize: size,
          color: isSaved ? Colors.yellow : null,
        );
      },
    );
  }
}
