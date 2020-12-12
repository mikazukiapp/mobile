import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mikazuki/mobile/config.dart';
import 'package:mikazuki/mobile/pages/AniList/Overview.dart';
import 'package:mikazuki/mobile/pages/loadingScreen.dart';
import 'package:mikazuki/mobile/pages/login.dart';
import 'package:mikazuki/mobile/pages/search.dart';

class MobileApp extends StatefulWidget {
  @override
  _MobileAppState createState() => _MobileAppState();
}

class _MobileAppState extends State<MobileApp> {
  @override
  void initState() {
    super.initState();

    appTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mikazuki',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder> {
        '/': (BuildContext context) => LoadingScreenWidget(),
        '/login': (BuildContext context) => LoginScreenWidget(),
        '/search': (BuildContext context) => SearchScreenWidget(),
        '/overview': (BuildContext context) => AniListOverviewWidget(),
      },
      themeMode: appTheme.currentTheme(),
      darkTheme:
          ThemeData.localize(ThemeData.dark(), GoogleFonts.nunitoTextTheme()),
      theme: ThemeData.localize(
          ThemeData.light().copyWith(primaryColor: Colors.green),
          GoogleFonts.nunitoTextTheme()),
    );
  }
}
