import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/config.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItem.dart';
import 'package:mikazuki/mobile/widgets/scaffold/appBar.dart';
import 'package:mikazuki/mobile/widgets/scaffold/bottomNavigationBar.dart';
import 'package:mikazuki/mobile/widgets/scaffold/drawer.dart';
import 'package:mikazuki/mobile/widgets/util/MikazukiExpansionTile.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';
import 'package:mikazuki/shared/AniList/types/UserList.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

class NewAniListOverviewWidget extends StatefulWidget {
  NewAniListOverviewWidget({Key key}) : super(key: key);

  @override
  _NewAniListOverviewWidgetState createState() =>
      _NewAniListOverviewWidgetState();
}

class _NewAniListOverviewWidgetState extends State<NewAniListOverviewWidget> {
  Map<AniListUserListStatus, AniListUserList> _map = {};
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    appTheme.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    _isLoading = true;
    AniListRepository.getInstance().getUserLists().then((lists) {
      setState(() {
        lists.forEach((element) {
          _map.putIfAbsent(element.status, () => element);
        });
      });
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void updateLists(List<AniListUserList> lists) {
    setState(() {
      lists.forEach((element) {
        _map.update(element.status, (e) => element, ifAbsent: () => element);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: MikazukiAppBar(title: 'Anime'),
      drawer: MikazukiDrawer(),
      bottomNavigationBar: MikazukiBottomNavBar(),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _isLoading = true;
            AniListRepository.getInstance()
                .getUserLists()
                .then(updateLists)
                .whenComplete(() {
              setState(() {
                _isLoading = false;
              });
            });
          });
        },
        child: ListView(
          children: _map.entries
              .map((mapEntry) => MikazukiExpansionTile(
                    key: PageStorageKey(UniqueKey()),
                    title: Text(mapEntry.value.name),
                    initiallyExpanded: true,
                    children: [
                      AnimatedList(
                        shrinkWrap: true,
                        key: UniqueKey(),
                        physics: const AlwaysScrollableScrollPhysics(),
                        initialItemCount: mapEntry.value.entries.length,
                        itemBuilder: (context, index, animation) {
                          return AniListOverviewListItem(
                            entry: mapEntry.value.entries[index],
                            removeEntry: null,
                            index: index,
                          );
                        },
                      ),
                    ],
                  ))
              .toList(),
        ),
      ),
    );
  }
}
