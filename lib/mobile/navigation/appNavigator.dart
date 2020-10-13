import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/search/result.dart';

class AppNavigator extends StatefulWidget {
  AppNavigator({Key key}) : super();

  @override
  AppNavigatorState createState() => AppNavigatorState();
}

class AppNavigatorState extends State<AppNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      pages: [
        MaterialPage(
          key: ValueKey('Home'),
          child: Scaffold(),
        ),
        MaterialPage(
          key: ValueKey('Search'),
          child: SearchResultPage(),
        )
      ],
      onPopPage: (route, result) => route.didPop(result),
      initialRoute: 'Home',
    );
  }
}
