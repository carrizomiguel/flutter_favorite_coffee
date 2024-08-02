import 'package:flutter/material.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({
    required this.currentIndex,
    required this.onCoffeePressed,
    required this.onSavesPressed,
    super.key,
  });

  final int currentIndex;
  final VoidCallback onCoffeePressed;
  final VoidCallback onSavesPressed;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(99),
        ),
        child: Row(
          children: [
            NavBarItem(
              key: const Key('nav_bar_coffee_button'),
              isActive: currentIndex == 0,
              icon: Icons.coffee,
              onPressed: onCoffeePressed,
            ),
            NavBarItem(
              key: const Key('nav_bar_save_button'),
              isActive: currentIndex == 1,
              icon: Icons.bookmark_border_rounded,
              onPressed: onSavesPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    required this.icon,
    required this.onPressed,
    required this.isActive,
    super.key,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: isActive ? Colors.white : Colors.grey.shade800,
        ),
        iconSize: 35,
        color: Colors.white,
      ),
    );
  }
}
