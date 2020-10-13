import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/navigation/AppRoutePath.dart';
import 'package:mikazuki/mobile/search/result.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  bool show404 = false;

  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
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
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        show404 = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath path) async {
    if (path.isUnknown) {
      show404 = true;
      return;
    }

    show404 = false;
  }
}

class AppRouteInformationParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.length == 0) {
      return AppRoutePath.home();
    }

    // /search
    if (uri.pathSegments.length == 1) {
      if (uri.pathSegments[0] != 'search') {
        return AppRoutePath.unknown();
      }

      return AppRoutePath.search();
    }

    return AppRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath path) {
    if (path.isUnknown) {
      return RouteInformation(location: '/404');
    }

    return RouteInformation(location: path.location);
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}
