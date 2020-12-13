import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/CompleteDialog.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItemElements/ListItemContent.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItemElements/ListItemHero.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItemMenu.dart';
import 'package:mikazuki/shared/AniList/types/DateInput.dart';
import 'package:mikazuki/shared/AniList/types/MediaStatus.dart';
import 'package:mikazuki/shared/AniList/types/UserListEntry.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

class AniListOverviewListItem extends StatefulWidget {
  final AniListUserListEntry entry;
  final int index;
  final void Function(int index) removeEntry;

  AniListOverviewListItem(
      {@required this.entry, @required this.index, @required this.removeEntry});

  @override
  _AniListOverviewListItemState createState() =>
      _AniListOverviewListItemState();
}

class _AniListOverviewListItemState extends State<AniListOverviewListItem> {
  int get entryId => widget.entry.id;
  int get progress => widget.entry.progress;
  double get score => widget.entry.score;
  int get episodes => widget.entry.media.episodes;
  int get nextEpisode => widget.entry.media.nextAiringEpisode?.episode;
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
  bool get isNextEpisodeFinal => widget.entry.isNextEpisodeFinal;
  bool isCompleted = false;

  SlidableController _controller = SlidableController();

  bool _isLoading = false;
  double temporaryScoreValue = 0;

  void increaseProgress({int steps = 1}) {
    _setProgress(progress + steps);
  }

  void decreaseProgress({int steps = 1}) {
    _setProgress(progress - steps);
  }

  void _setProgress(int value) {
    setState(() {
      widget.entry.progress = value;
      widget.entry.save();
    });
  }

  void setCompleted() {
    setState(() {
      isCompleted = true;
      widget.entry.progress = episodes;
      widget.entry.score = temporaryScoreValue ?? score;
      widget.entry.status = AniListUserListStatus.Completed;
      widget.entry.completedAt = AniListDateInput.fromNow();
      widget.entry.save(
        includeProgress: true,
        includeScore: true,
        includeStatus: true,
        includeCompletedAt: true,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    temporaryScoreValue = score ?? 0;
    isCompleted = widget.entry.status == AniListUserListStatus.Completed;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.2,
      controller: _controller,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListItemHero(entryId: entryId, coverImage: coverImage),
            ListItemContent(
              isLoading: _isLoading,
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
        dismissThresholds: <SlideActionType, double>{
          SlideActionType.primary: 0.5,
          SlideActionType.secondary: 1.0,
        },
        child: SlidableDrawerDismissal(),
        onWillDismiss: (SlideActionType type) async {
          if (isNextEpisodeFinal) {
            temporaryScoreValue = await showDialog<double>(
              context: context,
              barrierDismissible: false,
              builder: (context) => AniListCompleteDialog(
                isLoading: _isLoading,
                score: score,
                title: title,
              ),
            );

            return true;
          }

          increaseProgress();
          return false;
        },
        onDismissed: (SlideActionType type) {
          setCompleted();
          widget.removeEntry(widget.index);
          return;
        },
      ),
      actions: <Widget>[
        if (!isCompleted)
          IconSlideAction(
            icon: !isNextEpisodeFinal
                ? Icons.plus_one
                : Icons.check,
            color: Colors.green[700],
            onTap: () {
              if (isCompleted) {
                return;
              }

              if (isNextEpisodeFinal) {
                _controller.activeState.dismiss();
                return;
              }

              increaseProgress();
            },
          ),
      ],
      secondaryActions: <Widget>[
        if (progress > 0 && !isCompleted)
          IconSlideAction(
            icon: Icons.exposure_minus_1,
            color: Colors.red,
            onTap: () {
              if (progress == 0) {
                return;
              }

              decreaseProgress();
            },
          ),
        IconSlideAction(
          iconWidget: Icon(Icons.star, color: Colors.white,),
          color: Colors.yellow[800],
          onTap: () {
            print('stars go brrrrrr');
          },
        ),
        IconSlideAction(
          icon: Icons.more_horiz,
          color: Theme.of(context).primaryColor,
          onTap: () {
            showDialog<void>(
              context: context,
              builder: (context) => AniListOverviewListItemMenuWidget(),
            );
          },
        )
      ],
    );
  }
}
