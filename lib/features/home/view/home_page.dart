import 'package:coffee_repository/coffee_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:very_good_example/features/features.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CoffeeBloc(
            repository: context.read<CoffeeRepository>(),
          )..add(CoffeeRequested()),
        ),
        BlocProvider(create: (context) => SavesBloc()),
      ],
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() => _currentIndex = controller.page?.toInt() ?? 0);
    });
  }

  void _goTo(int index) {
    controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller,
            physics: const ClampingScrollPhysics(),
            children: const [
              CoffeePage(),
              SavesPage(),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: HomeNavBar(
              currentIndex: _currentIndex,
              onCoffeePressed: () => _goTo(0),
              onSavesPressed: () => _goTo(1),
            ),
          ),
        ],
      ),
    );
  }
}
