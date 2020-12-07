import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItem.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';
import 'package:mikazuki/shared/AniList/types/UserList.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

class AniListOverviewListWidget extends StatefulWidget {
  final AniListUserListStatus status;

  AniListOverviewListWidget({ @required Key key, @required this.status });

  @override
  _AniListOverviewListWidgetState createState() => _AniListOverviewListWidgetState();
}

class _AniListOverviewListWidgetState extends State<AniListOverviewListWidget> {
  Future<AniListUserList> _list;

  @override
  void initState() {
    super.initState();
    _list = AniListRepository.getInstance().getUserListByStatus(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _list,
      builder: (context, AsyncSnapshot<AniListUserList> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }

        if (snapshot.hasData) {
          return ListView.builder(
            itemExtent: 100.0,
            padding: EdgeInsets.only(left: 12.0, right: 12.0),
            itemCount: snapshot.data.entries.length,
            itemBuilder: (context, index) {
              return AniListOverviewListItem(entry: snapshot.data.entries[index]);
            },
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
