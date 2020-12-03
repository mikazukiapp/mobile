import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mikazuki/desktop/app.dart';
import 'package:mikazuki/mobile/app.dart';

Future main() async {
  await DotEnv().load('.env');

  runApp(MikazukiApp());
}

class MikazukiApp extends StatefulWidget {
  @override
  _MikazukiApp createState() => _MikazukiApp();
}

class _MikazukiApp extends State<MikazukiApp> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = Platform.isIOS || Platform.isAndroid;

    if (isMobile) {
      return MobileApp();
    }

    return DesktopApp();
  }
}
