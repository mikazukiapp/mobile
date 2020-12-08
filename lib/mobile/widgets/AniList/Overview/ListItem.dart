import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/util/HexColor.dart';
import 'package:mikazuki/shared/AniList/types/MediaStatus.dart';
import 'package:mikazuki/shared/AniList/types/UserListEntry.dart';

class AniListOverviewListItem extends StatefulWidget {
  final AniListUserListEntry entry;

  AniListOverviewListItem({ this.entry });

  @override
  _AniListOverviewListItemState createState() => _AniListOverviewListItemState();
}

class _AniListOverviewListItemState extends State<AniListOverviewListItem> {
  int get entryId => widget.entry.id;
  String get title => widget.entry.media.title.romaji;
  String get coverImage => widget.entry.media.coverImage.getSmallest();
  String get coverColor => widget.entry.media.coverImage.color;
  int get progress => widget.entry.progress;
  int get episodes => widget.entry.media.episodes;
  double get score => widget.entry.score;
  double get progressPercentage => widget.entry.progressPercentage;
  String get progressText => widget.entry.progressText;
  int get nextEpisode => widget.entry.media.nextAiringEpisode?.episode;
  double get nextEpisodeProgress => widget.entry.nextEpisodeProgressPercentage;
  String get airingAtDifference => widget.entry.media.nextAiringEpisode?.airingAtDifference;
  bool get isAiring => widget.entry.media.status == AniListMediaStatus.Releasing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 4.0, top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: entryId,
            child: SizedBox(
              width: 64.0,
              height: 96.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  coverImage,
                  fit: BoxFit.fitHeight,
                  cacheWidth: 64,
                  cacheHeight: 96,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return Center(
                      child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8.0, top: 4.0),
              height: 96.0,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: Text(title, maxLines: 2, overflow: TextOverflow.ellipsis, semanticsLabel: title)),
                      Container(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              score.toStringAsFixed(1) ?? '---',
                              style: TextStyle(
                                // color: Colors.grey[700],
                                fontSize: 12.0,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              // color: Colors.grey[700],
                              size: 12.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Episode $progressText',
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.0,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        if (isAiring)
                          Flexible(
                            flex: 1,
                            child: Icon(Icons.settings_input_antenna, size: 12.0, color: Colors.green,),
                          ),
                        if (nextEpisode != null)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: isAiring ? 4.0 : 0),
                            child: Text(
                              'Episode $nextEpisode is airing in $airingAtDifference',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12.0,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    overflow: Overflow.visible,
                    children: <Widget>[
                      SizedBox(
                        height: 6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2.0),
                          child: LinearProgressIndicator(
                            value: progressPercentage,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              coverColor != null ? HexColor.fromHex(coverColor) : Colors.green[800],
                            ),
                            backgroundColor: coverColor != null ? HexColor.fromHex(coverColor).withOpacity(0.4) : Colors.green[800].withOpacity(0.4),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(2.0), bottomRight: Radius.circular(2.0)),
                          child: LinearProgressIndicator(
                            value: nextEpisodeProgress,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              coverColor != null ? HexColor.fromHex(HexColor.calculateComplementaryColorFromHex(coverColor)) : Colors.orange[300]
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
