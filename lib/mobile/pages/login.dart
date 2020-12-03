import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mikazuki/mobile/app.dart';
import 'package:mikazuki/mobile/pages/search.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mikazuki/mobile/constants.dart';

class LoginScreenWidget extends StatefulWidget {
  @override
  _LoginScreenWidgetState createState() => _LoginScreenWidgetState();
}

class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  FlutterSecureStorage _secureStorage;
  StreamSubscription _sub;

  @override
  void initState() {
    super.initState();

    _secureStorage = new FlutterSecureStorage();

    this.initUniLinks();
  }

  Future<Null> initUniLinks() async {
    _sub = getUriLinksStream().listen((Uri link) async {
      if (!mounted) {
        return;
      }

      String accessToken = link.fragment;

      if (accessToken.startsWith('access_token=')) {
        accessToken = accessToken.substring(13);
        await _secureStorage.write(key: 'anilist_token', value: accessToken);

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => MobileApp()), (route) => false);
        _sub.cancel();
      }
    }, onError: (err) {
      print(err);
    });
  }

  void _launchAniListLoginSequence() async {
    String url = AniListAuthURL.replaceAll('{client_id}', DotEnv().env['CLIENT_ID']);

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Couldn't launch $url";
    }
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
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => SearchScreenWidget())),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
