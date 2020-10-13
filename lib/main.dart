import 'package:flutter/material.dart';
import 'package:mikazuki/desktop/app.dart';
import 'package:mikazuki/mobile/app.dart';
import 'dart:io' show Platform;

void main() {
  runApp(MikazukiApp());
}

class MikazukiApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isMobile = Platform.isIOS || Platform.isAndroid;

    if (isMobile) {
      return MobileApp();
    }

    return DesktopApp();
  }
}
