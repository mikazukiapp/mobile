import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mikazuki/mobile/constants.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  FlutterSecureStorage _secureStore;

  void _launchAniListLoginSequence() async {
    String url = AniListAuthURL.replaceAll('{client_id}', DotEnv().env['CLIENT_ID']);
    
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Couldn\'t launch $url';
    }
  }

  void _performLoginCheck() async {
    bool isTokenSet = (await _secureStore.read(key: 'anilist_token')).isNotEmpty;

    if (isTokenSet) {
      Navigator.of(context).pushReplacementNamed(homeRoute);
    }
  }

  @override
  void initState() {
    super.initState();
    _secureStore = new FlutterSecureStorage();

    _performLoginCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/login_background.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                child: Container(color: Colors.black.withOpacity(0.5)),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/images/AppIcon.png'),
                Text('Welcome to Mikazuki!'),
                Text('To effectively use Mikazuki, please log in to AniList.'),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: RaisedButton(
                    onPressed: _launchAniListLoginSequence,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    padding: EdgeInsets.all(0),
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.green,
                            Colors.lightBlue,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Container(
                        constraints:
                            BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                        alignment: Alignment.center,
                        child: Text('Login', textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  child: Text('Continue without login'),
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed(homeRoute),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
