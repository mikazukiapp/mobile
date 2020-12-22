import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:cached_network_image/cached_network_image.dart';

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

  List<Widget> routes = <Widget>[
    ListTile(
      title: Text('Lists'),
      leading: Icon(Icons.list),
      onTap: () {},
    ),
    ListTile(
      title: Text('Search'),
      leading: Icon(Icons.search),
      onTap: () {},
    ),
    Divider(),
    ListTile(
      title: Text('Settings'),
      leading: Icon(Icons.settings),
      onTap: () {},
    ),
  ];

  Map<String, int> routeIndicies = {
    '/overview': 1,
    '/search': 2,
    '/settings': 4,
  };

  Widget _getRoute(BuildContext context, int index) {
    bool isSelected = _selectedIndex == index;

    dynamic widget = routes[index];

    if (widget is ListTile) {
      return ListTile(
        title: widget.title,
        leading: widget.leading,
        selected: isSelected,
        onTap: widget.onTap,
      );
    }

    return widget;
  }

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    userDataBox = Hive.box('anilist_userdata');
    userAvatarImageLink = userDataBox.get('avatars')?.getSmallest();
    userBannerImage = userDataBox.get('bannerImage');

    routes.insert(
      0,
      DrawerHeader(
        child: Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: userAvatarImageLink,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('NicoAiko'),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Future.delayed(Duration.zero, () {
      String routeName = ModalRoute.of(context).settings.name;
      setState(() {
        _selectedIndex = routeIndicies[routeName] ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          if (userBannerImage != null)
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(userBannerImage),
                ),
              ),
            ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.75),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0),
            ),
          ),
          ListView.builder(
            itemCount: routes.length,
            itemBuilder: (context, index) {
              return _getRoute(context, index);
            },
            // Seems to be important
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
