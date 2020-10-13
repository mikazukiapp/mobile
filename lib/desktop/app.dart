import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mikazuki/desktop/home/home.dart';

class DesktopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mikazuki',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme)),
      home: Home(title: 'Mikazuki'),
    );
  }
}
