import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mikazuki/mobile/constants.dart';

class MikazukiDrawer extends StatefulWidget {
  MikazukiDrawer({Key key}) : super(key: key);

  @override
  _MikazukiDrawerState createState() => _MikazukiDrawerState();
}

class _MikazukiDrawerState extends State<MikazukiDrawer> {
  int _selectedIndex;

  List<Widget> routes = <Widget>[
    UserAccountsDrawerHeader(
      currentAccountPicture: SvgPicture.asset(kMikazukiSvgLogo),
      accountName: Text('NicoAiko'),
      accountEmail: null,
    ),
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

    Future.delayed(Duration.zero, () {
      String routeName = ModalRoute.of(context).settings.name;
      setState(() {
        _selectedIndex = routeIndicies[routeName] ?? 0;
        print(routeName);
        print(_selectedIndex);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return _getRoute(context, index);
        },
        // Seems to be important
        padding: EdgeInsets.zero,
      ),
    );
  }
}
