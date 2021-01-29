import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItem.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';
import 'package:mikazuki/shared/AniList/types/UserList.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

class AniListOverviewListWidget extends StatefulWidget {
  final AniListUserListStatus status;

  AniListOverviewListWidget({@required Key key, @required this.status});

  @override
  _AniListOverviewListWidgetState createState() =>
      _AniListOverviewListWidgetState();
}

class _AniListOverviewListWidgetState extends State<AniListOverviewListWidget>
    with AutomaticKeepAliveClientMixin<AniListOverviewListWidget> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  AniListUserList _userList;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _isLoading = true;
    AniListRepository.getInstance()
        .getUserListByStatus([widget.status]).then((value) {
      setState(() {
        _userList = value;
      });
    }).whenComplete(() {
      setState(() {
        _isLoading = false;
      });
    });
  }

  void removeEntry(int index) {
    setState(() {
      _userList.entries.removeAt(index);
      listKey.currentState.removeItem(
        index,
        // Due to Slidable dismissing the item itself
        // and AnimatedList continuing the animation,
        // to remove the item from the current state
        // as animation replacement, an empty container
        // that has no height, will be used so no disturbing
        // factor is showing.
        (context, animation) => Container(height: 0),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _isLoading = true;
          AniListRepository.getInstance()
              .getUserListByStatus([widget.status]).then((value) {
            setState(() {
              _userList = value;
            });
          }).whenComplete(() => _isLoading = false);
        });
      },
      child: AnimatedList(
        key: listKey,
        physics: const AlwaysScrollableScrollPhysics(),
        initialItemCount: _userList.entries.length,
        itemBuilder: (context, index, animation) {
          return AniListOverviewListItem(
            entry: _userList.entries[index],
            removeEntry: removeEntry,
            index: index,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
