import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/constants.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
                RaisedButton(
                  child: Text('Login'),
                  onPressed: () => print('login page of anilist'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
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
