import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:very_good_example/features/features.dart';

class SavesList extends StatelessWidget {
  const SavesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavesBloc, SavesState>(
      builder: (context, state) {
        final saves = state.saves;

        return MasonryGridView.builder(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 110),
          gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          itemCount: saves.length,
          itemBuilder: (context, index) {
            final url = saves.keys.elementAt(index);
            final photo = saves.values.elementAt(index);

            return Stack(
              key: Key('$index-$url'),
              children: [
                Image.memory(photo),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CoffeeSaveButton(
                      url: url,
                      image: photo,
                      size: 20,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
