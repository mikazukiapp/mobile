import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mikazuki/mobile/constants.dart';
import 'package:uni_links/uni_links.dart';
import 'package:mikazuki/desktop/app.dart';
import 'package:mikazuki/mobile/app.dart';

Future main() async {
  await DotEnv().load('.env');

  runApp(MikazukiApp());
}

class MikazukiApp extends StatefulWidget {
  @override
  _MikazukiApp createState() => new _MikazukiApp();
}

class _MikazukiApp extends State<MikazukiApp> {
  FlutterSecureStorage _secureStorage;
  StreamSubscription _sub;

  Future<Null> initUniLinks() async {
    _sub = getUriLinksStream().listen((Uri link) async {
      if (!mounted) {
        return;
      }

      print('Subscription-based Deep link incoming $link');
      String accessToken = link.fragment;
      print('access_token=$accessToken');

      if (accessToken.startsWith('access_token=')) {
        accessToken = accessToken.substring(13);
        await _secureStorage.write(key: 'anilist_token', value: accessToken);

        Navigator.of(context).pushReplacementNamed(homeRoute);
      }
    }, onError: (err) {
      print(err);
    });

    // try {
    //   Uri initialLink = await getInitialUri();
    //   String accessToken = initialLink.fragment;

    //   if (accessToken.startsWith('access_token=')) {
    //     accessToken = accessToken.substring(13);
    //     setState(() {
    //       _secureStorage.write(key: 'anilist_token', value: accessToken);
    //     });
    //   }

    //   // print('Initial $initialLink');
    // } on PlatformException {
    //   print('Failed to get initial Uri');
    // } on FormatException {
    //   print('Bad parse the initial link as Uri');
    // }
  }

  @override
  dispose() {
    if (_sub != null) {
      _sub.cancel();
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _secureStorage = new FlutterSecureStorage();

    this.initUniLinks();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = Platform.isIOS || Platform.isAndroid;

    if (isMobile) {
      return MobileApp();
    }

    return DesktopApp();
  }
}
