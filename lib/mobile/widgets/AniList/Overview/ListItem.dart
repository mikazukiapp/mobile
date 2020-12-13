import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/CompleteDialog.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItemElements/ListItemContent.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItemElements/ListItemHero.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';
import 'package:mikazuki/shared/AniList/types/DateInput.dart';
import 'package:mikazuki/shared/AniList/types/MediaStatus.dart';
import 'package:mikazuki/shared/AniList/types/UserListEntry.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

class AniListOverviewListItem extends StatefulWidget {
  final AniListUserListEntry entry;
  final int listItemIndex;
  final void Function(int index) removeElement;
  final Future<void> Function() refreshList;
  final void Function(int index,
      {int progress, double score, AniListUserListStatus status}) updateEntry;

  AniListOverviewListItem(
      {@required this.entry,
      @required this.listItemIndex,
      @required this.removeElement,
      @required this.refreshList,
      @required this.updateEntry});

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
  bool get isNextEpisodeFinal => widget.entry.isNextEpisodeFinal;

  SlidableController _controller = SlidableController();

  bool _isLoading = false;
  double temporaryScoreValue = 0;

  @override
  void initState() {
    super.initState();
    temporaryScoreValue = score ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(entryId),
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.25,
      controller: _controller,
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

            setState(() {
              _isLoading = true;
              AniListRepository.getInstance()
                  .updateEntry(entryId,
                      progress: episodes,
                      score: temporaryScoreValue ?? score,
                      status: AniListUserListStatus.Completed,
                      completedAt: AniListDateInput.fromNow())
                  .then((entry) => widget.updateEntry(widget.listItemIndex,
                      progress: entry.progress,
                      score: entry.score,
                      status: entry.status))
                  .whenComplete(() => setState(() => _isLoading = false));
            });
          } else {
            setState(() {
              _isLoading = true;
              AniListRepository.getInstance()
                  .updateEntry(entryId, progress: progress + 1)
                  .then((entry) => widget.updateEntry(widget.listItemIndex,
                      progress: entry.progress))
                  .whenComplete(() => setState(() => _isLoading = false));
            });
          }

          return isNextEpisodeFinal;
        },
        onDismissed: (SlideActionType type) {
          widget.removeElement(widget.listItemIndex);
        },
      ),
      actions: <Widget>[
        IconSlideAction(
          icon: !isNextEpisodeFinal ? Icons.plus_one : Icons.check,
          color: Colors.green[700],
          onTap: () {
            if (isNextEpisodeFinal) {
              _controller.activeState.dismiss();
              return;
            }

            setState(() {
              _isLoading = true;
              AniListRepository.getInstance()
                  .updateEntry(entryId, progress: progress + 1)
                  .then((entry) => widget.updateEntry(widget.listItemIndex,
                      progress: entry.progress))
                  .whenComplete(() => setState(() => _isLoading = false));
            });
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          icon: Icons.more_horiz,
          color: Theme.of(context).primaryColor,
          onTap: () {
            // TODO: Add menu for extra functions here
          },
        )
      ],
    );
  }
}
