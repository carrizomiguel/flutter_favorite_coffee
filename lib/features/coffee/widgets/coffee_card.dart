import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_example/features/features.dart';


class CoffeeCard extends StatefulWidget {
  const CoffeeCard({super.key});

  @override
  State<CoffeeCard> createState() => _CoffeeCardState();
}

class _CoffeeCardState extends State<CoffeeCard> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    final coffeeBloc = context.read<CoffeeBloc>();

    final height = MediaQuery.sizeOf(context).height;

    return BlocBuilder<CoffeeBloc, CoffeeState>(
      builder: (context, state) {
        final currentUrl = state.currentUrl;
        final currentCoffe = state.currentCoffee;
        final isLoading = state.status.isLoading;

        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: height * 0.5,
                ),
                child: CoffeeImage(
                  bytes: currentCoffe,
                  width: double.infinity,
                  isLoading: isLoading,
                  borderRadius: 20,
                  fit: BoxFit.fitWidth,
                ),
              ),
              const SizedBox(height: 20),
              const CoffeeErrorCard(),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CoffeeSaveButton(
                        url: currentUrl,
                        image: currentCoffe,
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        key: const Key('new_coffee_button'),
                        onPressed: () {
                          coffeeBloc.add(
                            CoffeeRequested(),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                        ),
                        iconSize: 35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
