import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mikazuki/mobile/constants.dart';
import 'package:mikazuki/mobile/home.dart';
import 'package:mikazuki/mobile/navigation/bottomBar.dart';
import 'package:mikazuki/mobile/navigation/router.dart';
import 'package:mikazuki/mobile/search/result.dart';

class MobileApp extends StatefulWidget {
  @override
  _MobileAppState createState() => _MobileAppState();
}

class _MobileAppState extends State<MobileApp> {
  int _currentIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Home(),
    SearchResultPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mikazuki',
      debugShowCheckedModeBanner: false,
      initialRoute: homeRoute,
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          )),
      home: Scaffold(
        appBar: AppBar(
          leading: Container(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/AppIcon.png',
            ),
          ),
          title: Text('NicoAiko'),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Colors.green[500],
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: _widgetOptions.elementAt(_currentIndex),
      ),
    );
  }
}
