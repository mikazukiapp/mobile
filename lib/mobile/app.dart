import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mikazuki/mobile/config.dart';
import 'package:mikazuki/mobile/constants.dart';
import 'package:mikazuki/mobile/home.dart';
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
  void initState() {
    super.initState();

    appTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Mikazuki',
        debugShowCheckedModeBanner: false,
        initialRoute: homeRoute,
        onGenerateRoute: AppRouter.generateRoute,
        themeMode: appTheme.currentTheme(),
        darkTheme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        theme: ThemeData.light().copyWith(
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: GoogleFonts.nunitoTextTheme().caption,
            helperStyle: GoogleFonts.nunitoTextTheme().caption,
            labelStyle: GoogleFonts.nunitoTextTheme().caption,
          ),
          textTheme: GoogleFonts.nunitoTextTheme(
            Theme.of(context).textTheme,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Scaffold(
          appBar: AppBar(
            leading: Container(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/AppIcon.png',
              ),
            ),
            title: Text('NicoAiko'),
            actions: [
              IconButton(
                  icon: appTheme.currentTheme() == ThemeMode.light
                      ? Icon(Icons.lightbulb, color: Colors.yellow)
                      : Icon(Icons.lightbulb_outline, color: Colors.white),
                  onPressed: () {
                    appTheme.switchTheme();
                  })
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
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
      ),
    );
  }
}
