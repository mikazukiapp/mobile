import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItemElements/ListItemContent.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItemElements/ListItemHero.dart';
import 'package:mikazuki/shared/AniList/types/MediaStatus.dart';
import 'package:mikazuki/shared/AniList/types/UserListEntry.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AniListOverviewListItem extends StatefulWidget {
  final AniListUserListEntry entry;

  AniListOverviewListItem({this.entry});

  @override
  _AniListOverviewListItemState createState() =>
      _AniListOverviewListItemState();
}

class _AniListOverviewListItemState extends State<AniListOverviewListItem> {
  int get entryId => widget.entry.id;
  int get progress => widget.entry.progress;
  int get episodes => widget.entry.media.episodes;
  int get nextEpisode => widget.entry.media.nextAiringEpisode?.episode;
  double get score => widget.entry.score;
  double get progressPercentage => widget.entry.progressPercentage;
  double get nextEpisodeProgress => widget.entry.nextEpisodeProgressPercentage;
  String get title => widget.entry.media.title.romaji;
  String get coverImage => widget.entry.media.coverImage.extraLarge;
  String get coverColor => widget.entry.media.coverImage.color;
  String get progressText => widget.entry.progressText;
  String get airingAtDifference =>
      widget.entry.media.nextAiringEpisode?.airingAtDifference;
  bool get isAiring =>
      widget.entry.media.status == AniListMediaStatus.Releasing;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(entryId),
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListItemHero(entryId: entryId, coverImage: coverImage),
            ListItemContent(
              title: title,
              score: score,
              progressText: progressText,
              isAiring: isAiring,
              nextEpisode: nextEpisode,
              airingAtDifference: airingAtDifference,
              nextEpisodeProgress: nextEpisodeProgress,
              progressPercentage: progressPercentage,
            ),
          ],
        ),
      ),
      dismissal: SlidableDismissal(
        closeOnCanceled: true,
        dismissThresholds: <SlideActionType, double> {
          SlideActionType.primary: 0.5,
          SlideActionType.secondary: 1.0,
        },
        child: SlidableDrawerDismissal(),
        onWillDismiss: (SlideActionType type) async {
          // Add actions here
          return false;
        },
      ),
      actions: <Widget>[
        IconSlideAction(
          icon: Icons.plus_one,
          color: Colors.green[700],
          onTap: () {
            print('tapped');
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          icon: Icons.more_horiz,
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
