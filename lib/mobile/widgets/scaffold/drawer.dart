import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';

class MikazukiDrawer extends StatefulWidget {
  MikazukiDrawer({Key key}) : super(key: key);

  @override
  _MikazukiDrawerState createState() => _MikazukiDrawerState();
}

class _MikazukiDrawerState extends State<MikazukiDrawer> {
  int _selectedIndex;
  Box<dynamic> userDataBox;
  String userAvatarImageLink;
  String userBannerImage;
  String username;

  // TODO: Use Navigator 2.0 for navigation
  List<Widget> _getRoutes(BuildContext context) {
    bool isLoggedIn = AniListRepository.getInstance().isLoggedIn;
    List<Widget> routes = [];

    routes.add(
      UserAccountsDrawerHeader(
        accountName: Text(username),
        accountEmail: Text(
          "Next update in: To be implemented",
          style: TextStyle(fontSize: 12.0),
        ),
        currentAccountPicture: _accountPicture(context),
      ),
    );

    if (isLoggedIn) {
      routes.add(
        ListTile(
          title: Text('Lists'),
          leading: Icon(Icons.list),
          selected: _selectedIndex == 1,
          onTap: () {
            Navigator.pushNamed(context, '/overview');
          },
        ),
      );
    } else {
      routes.add(
        ListTile(
          title: Text('Login'),
          leading: Icon(Icons.login),
          selected: _selectedIndex == 1,
          onTap: () {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
          },
        ),
      );
    }

    routes.add(
      ListTile(
        title: Text('Search'),
        leading: Icon(Icons.search),
        selected: _selectedIndex == 2,
        onTap: () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          Navigator.pushNamed(context, '/search');
        },
      ),
    );

    return routes;
  }

  Widget _accountPicture(BuildContext context) {
    if (userAvatarImageLink != null) {
      return CircleAvatar(
        backgroundImage: NetworkImage(
          userAvatarImageLink,
        ),
        radius: 4.0,
      );
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    if (Hive.isBoxOpen('anilist_userdata')) {
      userDataBox = Hive.box('anilist_userdata');
      userAvatarImageLink = userDataBox.get('avatars')?.getSmallest();
      userBannerImage = userDataBox.get('bannerImage');
      username = userDataBox.get('username');
    } else {
      userAvatarImageLink = null;
      userBannerImage = null;
      username = "Unauthorized";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Row(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.tight,
            child: SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color:
                          Theme.of(context).backgroundColor.withOpacity(0.25),
                      width: 1.0,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      margin: EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white),
                      ),
                      child: SvgPicture.asset(
                          "assets/images/appLogos/AniListLogo.svg"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ListView.builder(
              itemCount: _getRoutes(context).length,
              itemBuilder: (context, index) {
                return _getRoutes(context)[index];
              },
              // Seems to be important
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
    );
  }
}
