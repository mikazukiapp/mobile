import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/search/baseResultItem.dart';
import 'package:mikazuki/shared/AniList/types/Media.dart';
import 'package:mikazuki/shared/AniList/types/MediaStatus.dart';

class AnimeSearchResultItemWidget extends BaseSearchResultItemWidget {
  const AnimeSearchResultItemWidget(this.item, {Key key}) : super(key: key);
  final AniListMedia item;

  String get score {
    return item.averageScore?.toString() ?? '?';
  }

  String get statusLine {
    return '${item.episodes?.toString() ?? "Unknown amount of"} episodes';
  }

  String get bottomLine {
    return '${item.formatTitle}, ${item.statusTitle}';
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
    return this.baseContainer(context, <Widget>[
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
    ]);
  }
}
