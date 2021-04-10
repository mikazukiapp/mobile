import 'package:flutter/material.dart';

class MikazukiBottomNavBar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MikazukiBottomNavBarState();
}

class MikazukiBottomNavBarState extends State<MikazukiBottomNavBar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.tv), label: 'Anime'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Manga'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      ],
      currentIndex: _currentIndex,
      selectedItemColor: Colors.green[500],
      showUnselectedLabels: false,
      showSelectedLabels: true,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}
