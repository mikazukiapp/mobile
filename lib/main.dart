import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mikazuki/desktop/app.dart';
import 'package:mikazuki/mobile/app.dart';
import 'package:mikazuki/shared/AniList/types/UserAvatar.dart';

Future main() async {
  await DotEnv().load('.env');
  await Hive.initFlutter();
  Hive.registerAdapter(AniListUserAvatarAdapter());

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
