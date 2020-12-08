import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/config.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/List.dart';
import 'package:mikazuki/mobile/widgets/scaffold/appBar.dart';
import 'package:mikazuki/shared/AniList/types/UserList.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

class AniListOverviewWidget extends StatefulWidget {
  @override
  _AniListOverviewWidgetState createState() => _AniListOverviewWidgetState();
}

class _AniListOverviewWidgetState extends State<AniListOverviewWidget> {
  Future<List<AniListUserList>> userLists;
  int _bottomNavBarIndex = 0;
  List<Widget> tabs = <Widget>[
    AniListOverviewListWidget(
        key: Key('anilist_list_current'),
        status: AniListUserListStatus.Current),
    AniListOverviewListWidget(
        key: Key('anilist_list_repeating'),
        status: AniListUserListStatus.Repeating),
    AniListOverviewListWidget(
        key: Key('anilist_list_completed'),
        status: AniListUserListStatus.Completed),
    AniListOverviewListWidget(
        key: Key('anilist_list_paused'), status: AniListUserListStatus.Paused),
    AniListOverviewListWidget(
        key: Key('anilist_list_dropped'),
        status: AniListUserListStatus.Dropped),
    AniListOverviewListWidget(
        key: Key('anilist_list_planning'),
        status: AniListUserListStatus.Planning),
  ];

  List<BottomNavigationBarItem> _barItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(label: 'Current', icon: Icon(Icons.play_arrow)),
    BottomNavigationBarItem(label: 'Repeating', icon: Icon(Icons.repeat)),
    BottomNavigationBarItem(label: 'Completed', icon: Icon(Icons.check)),
    BottomNavigationBarItem(label: 'Paused', icon: Icon(Icons.pause)),
    BottomNavigationBarItem(label: 'Dropped', icon: Icon(Icons.stop)),
    BottomNavigationBarItem(label: 'Planning', icon: Icon(Icons.access_time)),
  ];

  Map<int, Color> darkModeSelectionColors = {
    0: Colors.green[500],
    1: Colors.green[100],
    2: Colors.blue[200],
    3: Colors.yellow[300],
    4: Colors.red[500],
    5: Colors.white,
  };

  Map<int, Color> lightModeSelectionColors = {
    0: Colors.green[500],
    1: Colors.green[900],
    2: Colors.blue[900],
    3: Colors.yellow[900],
    4: Colors.red[900],
    5: Colors.black,
  };

  void _onItemTapped(int index) {
    setState(() {
      _bottomNavBarIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    appTheme.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MikazukiAppBar('Mikazuki'),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: appTheme.currentTheme() == ThemeMode.dark
            ? darkModeSelectionColors[_bottomNavBarIndex]
            : lightModeSelectionColors[_bottomNavBarIndex],
        items: _barItems,
        currentIndex: _bottomNavBarIndex,
        onTap: _onItemTapped,
        unselectedItemColor: Theme.of(context).iconTheme.color,
      ),
      body: IndexedStack(
        index: _bottomNavBarIndex,
        children: tabs,
      ),
    );
  }
}
