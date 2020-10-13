import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mikazuki/mobile/navigation/router.dart';

class MobileApp extends StatefulWidget {
  @override
  _MobileAppState createState() => _MobileAppState();
}

class _MobileAppState extends State<MobileApp> {
  AppRouterDelegate _appRouterDelegate = AppRouterDelegate();
  AppRouteInformationParser _routeInformationParser =
      AppRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mikazuki',
      routerDelegate: _appRouterDelegate,
      routeInformationParser: _routeInformationParser,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          )),
    );
  }
}
