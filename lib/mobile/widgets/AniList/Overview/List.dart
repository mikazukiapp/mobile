import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItem.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';
import 'package:mikazuki/shared/AniList/types/UserList.dart';
import 'package:mikazuki/shared/AniList/types/UserListEntry.dart';
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
  AniListUserList _userList;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    _isLoading = true;
    AniListRepository.getInstance().getUserListByStatus(widget.status)
      .then((value) {
        setState(() {
          _userList = value;
        });
      })
      .whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
  }

  void removeEntry(int index) {
    setState(() {
      _userList.entries.removeAt(index);
    });
  }

  Future<void> refreshList() async {
    setState(() {
      _isLoading = true;
    });

    _userList = await AniListRepository.getInstance().getUserListByStatus(widget.status);

    setState(() {
      _isLoading = false;
    });
  }

  void updateEntry(int index, {int progress, double score, AniListUserListStatus status}) {
    AniListUserListEntry entry = _userList.entries.elementAt(index);

    if (progress != null) {
      entry.progress = progress;
    }

    if (score != null) {
      entry.score = score;
    }

    if (status != null) {
      refreshList();
    }
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
          AniListRepository.getInstance().getUserListByStatus(widget.status)
            .then((value) {
              setState(() {
                _userList = value;
              });
            })
            .whenComplete(() => _isLoading = false);
        });
      },
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemExtent: 100.0,
        itemCount: _userList.entries.length,
        itemBuilder: (context, index) {
          return AniListOverviewListItem(
            entry: _userList.entries[index],
            listItemIndex: index,
            removeElement: removeEntry,
            refreshList: refreshList,
            updateEntry: updateEntry,
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
