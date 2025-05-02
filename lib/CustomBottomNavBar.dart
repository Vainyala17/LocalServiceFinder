import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.green.shade400,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),          // index 0
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Orders"), // index 1
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),          // index 2
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favourite"), // index 3
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),     // index 4
      ],
    );
  }
}
