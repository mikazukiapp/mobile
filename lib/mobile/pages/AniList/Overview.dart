// import 'package:flutter/material.dart';
// import 'package:mikazuki/mobile/config.dart';
// import 'package:mikazuki/mobile/widgets/AniList/Overview/List.dart';
// import 'package:mikazuki/mobile/widgets/scaffold/appBar.dart';
// import 'package:mikazuki/mobile/widgets/scaffold/drawer.dart';
// import 'package:mikazuki/shared/AniList/types/UserList.dart';
// import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

// class AniListOverviewWidget extends StatefulWidget {
//   @override
//   _AniListOverviewWidgetState createState() => _AniListOverviewWidgetState();
// }

// class _AniListOverviewWidgetState extends State<AniListOverviewWidget> {
//   PageController _controller;
//   Future<List<AniListUserList>> userLists;
//   int _bottomNavBarIndex = 0;
//   bool _inBottomNavBarAnimation = false;
//   List<Widget> tabs = <Widget>[
//     AniListOverviewListWidget(
//         key: Key('anilist_list_current'),
//         status: AniListUserListStatus.Current),
//     AniListOverviewListWidget(
//         key: Key('anilist_list_paused'), status: AniListUserListStatus.Paused),
//     AniListOverviewListWidget(
//         key: Key('anilist_list_completed'),
//         status: AniListUserListStatus.Completed),
//     AniListOverviewListWidget(
//         key: Key('anilist_list_repeating'),
//         status: AniListUserListStatus.Repeating),
//     AniListOverviewListWidget(
//         key: Key('anilist_list_dropped'),
//         status: AniListUserListStatus.Dropped),
//     AniListOverviewListWidget(
//         key: Key('anilist_list_planning'),
//         status: AniListUserListStatus.Planning),
//   ];

//   List<BottomNavigationBarItem> _barItems = <BottomNavigationBarItem>[
//     BottomNavigationBarItem(label: 'Current', icon: Icon(Icons.play_arrow)),
//     BottomNavigationBarItem(label: 'Paused', icon: Icon(Icons.pause)),
//     BottomNavigationBarItem(label: 'Completed', icon: Icon(Icons.check)),
//     BottomNavigationBarItem(label: 'Repeating', icon: Icon(Icons.repeat)),
//     BottomNavigationBarItem(label: 'Dropped', icon: Icon(Icons.stop)),
//     BottomNavigationBarItem(label: 'Planning', icon: Icon(Icons.access_time)),
//   ];

//   Map<int, Color> darkModeSelectionColors = {
//     0: Colors.green[500],
//     1: Colors.yellow[300],
//     2: Colors.blue[200],
//     3: Colors.green[100],
//     4: Colors.red[500],
//     5: Colors.white,
//   };

//   Map<int, Color> lightModeSelectionColors = {
//     0: Colors.green[500],
//     1: Colors.yellow[900],
//     2: Colors.blue[900],
//     3: Colors.green[900],
//     4: Colors.red[900],
//     5: Colors.black,
//   };

//   void _onItemTapped(int index) {
//     setState(() {
//       _bottomNavBarIndex = index;
//       _inBottomNavBarAnimation = true;
//       _controller
//           .animateToPage(index,
//               duration: Duration(milliseconds: 200), curve: Curves.easeInOut)
//           .whenComplete(() => (_inBottomNavBarAnimation = false));
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     _controller = PageController();

//     appTheme.addListener(() {
//       if (mounted) {
//         setState(() {});
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: MikazukiAppBar(title: 'Anime'),
//       drawer: MikazukiDrawer(),
//       bottomNavigationBar: BottomNavigationBar(
//         selectedItemColor: appTheme.currentTheme() == ThemeMode.dark
//             ? darkModeSelectionColors[_bottomNavBarIndex]
//             : lightModeSelectionColors[_bottomNavBarIndex],
//         items: _barItems,
//         currentIndex: _bottomNavBarIndex,
//         onTap: _onItemTapped,
//         unselectedItemColor: Theme.of(context).iconTheme.color,
//       ),
//       body: PageView(
//         controller: _controller,
//         onPageChanged: (index) {
//           if (!_inBottomNavBarAnimation) {
//             setState(() => _bottomNavBarIndex = index);
//           }
//         },
//         children: tabs,
//       ),
//     );
//   }
// }
