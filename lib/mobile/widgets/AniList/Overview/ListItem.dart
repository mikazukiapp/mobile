import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/util/HexColor.dart';
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
                      Expanded(flex: 2, child: Text(title, maxLines: 3)),
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
                  Spacer(),
                  Text(
                    progressText,
                    style: TextStyle(
                      // color: Colors.grey[700],
                      fontSize: 12.0,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: LinearProgressIndicator(
                      value: progressPercentage,
                      valueColor: coverColor != null ? AlwaysStoppedAnimation<Color>(HexColor.fromHex(coverColor)) : null,
                    ),
                  ),
                  // Text(
                  //   item.statusTitle,
                  //   style: TextStyle(
                  //     // color: Colors.grey[700],
                  //     fontSize: 12.0,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
