import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/config.dart';
import 'package:mikazuki/mobile/pages/login.dart';
import 'package:mikazuki/mobile/widgets/util/NoAnimationMaterialPageRoute.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';
import 'package:mikazuki/shared/Storage/actions.dart';

class MikazukiAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String _title;

  MikazukiAppBar(this._title);

  @override
  State<StatefulWidget> createState() => MikazukiAppBarState(_title);

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class MikazukiAppBarState extends State<MikazukiAppBar> {
  String _title;

  MikazukiAppBarState(this._title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: Container(
        padding: EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/AppIcon.png',
        ),
      ),
      title: Text(_title),
      actions: <Widget>[
        IconButton(
          icon: Icon(AniListRepository.getInstance().isLoggedIn ? Icons.logout : Icons.login),
          onPressed: () {
            if (AniListRepository.getInstance().isLoggedIn) {
              SecureStorageActions.delete('anilist_token');
              Navigator.pushAndRemoveUntil(
                context,
                NoAnimationMaterialPageRoute(
                  builder: (BuildContext context) => LoginScreenWidget()
                ),
                (route) => false
              );
            } else {
              Navigator.pushNamed(context, '/login');
            }
          }
        ),
        IconButton(
            icon: appTheme.currentTheme() == ThemeMode.light
                ? Icon(Icons.lightbulb, color: Colors.yellow)
                : Icon(Icons.lightbulb_outline, color: Colors.white),
            onPressed: () {
              appTheme.switchTheme();
            })
      ],
    );
  }
}
