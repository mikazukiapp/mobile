import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mikazuki/mobile/home.dart';
import 'login/login.dart';

class LoadingWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoadingWidget();
}

class _LoadingWidget extends State<LoadingWidget> {
  FlutterSecureStorage _secureStorage = new FlutterSecureStorage();

  _LoadingWidget() {
    _secureStorage.read(key: 'anilist_token').then((token) {
      if (token != null && token.isNotEmpty) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => Home(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => LoginView(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}