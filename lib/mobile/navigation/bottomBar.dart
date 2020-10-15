import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/constants.dart';

class BottomNavBar extends StatefulWidget {
  final int currentIndex;

  BottomNavBar({Key key, this.currentIndex}) : super();

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State {
  int _currentIndex = 0;
  List<String> routes = [
    homeRoute,
    searchRoute,
  ];

  void _onItemTapped(BuildContext context, int index) {
    setState(() {
      _currentIndex = index;
      // Navigator.pushNamed(context, routes[index]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      ],
      currentIndex: _currentIndex,
      // showSelectedLabels: true,
      showUnselectedLabels: true,
      // unselectedIconTheme: IconThemeData(size: 24.0),
      selectedItemColor: Colors.green[500],
      onTap: (int index) {
        return _onItemTapped(context, index);
      },
    );
  }
}
