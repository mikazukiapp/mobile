import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mikazuki/mobile/constants.dart';
import 'package:mikazuki/mobile/pages/login.dart';
import 'package:mikazuki/mobile/widgets/util/NoAnimationMaterialPageRoute.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';

class MikazukiAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  MikazukiAppBar({this.title});

  @override
  State<StatefulWidget> createState() => MikazukiAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class MikazukiAppBarState extends State<MikazukiAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
          icon: SvgPicture.asset(kMikazukiSvgLogo),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          }),
      title: widget.title != null ? Text(widget.title) : null,
      actions: <Widget>[
        IconButton(
            icon: Icon(AniListRepository.getInstance().isLoggedIn
                ? Icons.logout
                : Icons.login),
            onPressed: () {
              if (AniListRepository.getInstance().isLoggedIn) {
                print('Logging out...');
                AniListRepository.getInstance().logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    NoAnimationMaterialPageRoute(
                        builder: (BuildContext context) => LoginScreenWidget()),
                    (route) => false);
              } else {
                Navigator.pushNamed(context, '/login');
              }
            }),
        //   IconButton(
        //       icon: appTheme.currentTheme() == ThemeMode.light
        //           ? Icon(Icons.lightbulb, color: Colors.yellow)
        //           : Icon(Icons.lightbulb_outline, color: Colors.white),
        //       onPressed: () {
        //         setState(() {
        //           appTheme.switchTheme();
        //         });
        //       })
      ],
    );
  }
}
