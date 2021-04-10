import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mikazuki/mobile/widgets/search/baseResultItem.dart';
import 'package:mikazuki/shared/AniList/types/Media.dart';
import 'package:mikazuki/shared/AniList/types/MediaStatus.dart';

class AnimeSearchResultItemWidget extends BaseSearchResultItemWidget {
  AnimeSearchResultItemWidget(this.item, {Key key}) : super(key: key);
  final AniListMedia item;
  final SlidableController _controller = SlidableController();

  String get score {
    return item.averageScore?.toString() ?? '?';
  }

  String get statusLine {
    String suffix = item.episodes == 1 ? 'episode' : 'episodes';
    return '${item.episodes?.toString() ?? "Unknown amount of"} $suffix';
  }

  String get bottomLine {
    if (item.mediaListEntry == null) {
      return 'Not an entry on your list';
    }

    return '${item.formatTitle}, on ${item.mediaListEntry.statusText} list';
  }

  Widget get mediaStatus {
    switch (item.status) {
      case AniListMediaStatus.Cancelled:
        return Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.live_tv,
              size: 16.0,
            ),
            Icon(
              Icons.dnd_forwardslash,
              size: 24.0,
              color: Colors.red,
            ),
          ],
        );
      case AniListMediaStatus.Finished:
        return Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.tv,
              size: 12.0,
            ),
            Icon(
              Icons.check,
              size: 24.0,
              color: Colors.blue,
            ),
          ],
        );
      case AniListMediaStatus.NotYetReleased:
        return Icon(
          Icons.date_range,
          size: 16.0,
        );
      case AniListMediaStatus.Releasing:
        return Icon(
          Icons.live_tv,
          size: 16.0,
        );
      default:
        return Icon(
          Icons.error,
          size: 16.0,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      controller: _controller,
      actionPane: SlidableScrollActionPane(),
      actionExtentRatio: 0.2,
      dismissal: SlidableDismissal(
        closeOnCanceled: true,
        dismissThresholds: <SlideActionType, double>{
          SlideActionType.primary: 0.5,
          SlideActionType.secondary: 1.0,
        },
        child: SlidableDrawerDismissal(),
        onWillDismiss: (SlideActionType type) async {
          return false;
        },
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          icon: Icons.info,
          color: Colors.blue,
          onTap: () {
            // TODO: Navigate to info page here
            print('${item.title.userPreferred} called');
          },
        ),
      ],
      child: this.baseContainer(context, <Widget>[
        this.heroImage(context, item.id, item.coverImage.getSmallest()),
        this.textContainer(context, item.title.userPreferred,
            statusLine: statusLine, bottomLine: bottomLine),
        this.scoreContainer(context, score, columnChildren: [
          Spacer(),
          if (item.isAdult)
            Icon(
              Icons.explicit_outlined,
              color: Colors.red,
              size: 20.0,
            ),
          this.mediaStatus,
        ]),
      ]),
    );
  }
}
