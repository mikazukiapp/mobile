import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/constants.dart';
import 'package:mikazuki/mobile/home.dart';
import 'package:mikazuki/mobile/search/result.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => Home());
      case searchRoute:
        return MaterialPageRoute(builder: (_) => SearchResultPage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
