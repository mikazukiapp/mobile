import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/search/baseResultItem.dart';
import 'package:mikazuki/shared/AniList/types/Media.dart';
import 'package:mikazuki/shared/AniList/types/MediaStatus.dart';

class MangaSearchResultItemWidget extends BaseSearchResultItemWidget {
  const MangaSearchResultItemWidget(this.item, {Key key}) : super(key: key);
  final AniListMedia item;

  String get score {
    return item.averageScore?.toString() ?? item.meanScore?.toString() ?? '?';
  }

  String get statusLine {
    String chapters = '${item.chapters?.toString() ?? "?"} chapters';
    String volumes = '${item.volumes?.toString() ?? "?"} volumes';

    return '$chapters, $volumes';
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
              Icons.menu_book_outlined,
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
        return Icon(
          Icons.book,
          size: 20.0,
        );
      case AniListMediaStatus.NotYetReleased:
        return Icon(
          Icons.book_online,
          size: 20.0,
        );
      case AniListMediaStatus.Releasing:
        return Icon(
          Icons.menu_book_outlined,
          size: 20.0,
        );
      default:
        return Icon(
          Icons.error,
          size: 20.0,
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
