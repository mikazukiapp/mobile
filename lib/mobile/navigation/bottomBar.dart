import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/home.dart';
import 'package:mikazuki/mobile/search/result.dart';

class BottomNavBar extends StatefulWidget {
  BottomNavBar({Key key}) : super();

  @override
  BottomNavBarState createState() => BottomNavBarState();
}

class BottomNavBarState extends State {
  int _selectedIndex = 0;
  List<Widget> routes = [
    Home(),
    SearchResultPage(),
  ];

  void _onItemTapped(BuildContext context, int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => routes[index]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green[500],
      onTap: (int index) {
        return _onItemTapped(context, index);
      },
    );
  }
}
