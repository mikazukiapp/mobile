import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItemElements/ListItemNextAiringEpisode.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItemElements/ListItemProgress.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItemElements/ListItemProgressText.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItemElements/ListItemScore.dart';
import 'package:mikazuki/mobile/widgets/AniList/Overview/ListItemElements/ListItemTitle.dart';

class ListItemContent extends StatelessWidget {
  const ListItemContent({
    Key key,
    @required this.title,
    @required this.score,
    @required this.progressText,
    @required this.isAiring,
    @required this.nextEpisode,
    @required this.airingAtDifference,
    @required this.nextEpisodeProgress,
    @required this.progressPercentage,
    @required this.isLoading,
  }) : super(key: key);

  final String title;
  final double score;
  final String progressText;
  final bool isAiring;
  final int nextEpisode;
  final String airingAtDifference;
  final double nextEpisodeProgress;
  final double progressPercentage;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: 8.0, top: 4.0),
        height: 96.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListItemTitle(title: title),
                ListItemScore(score: score),
              ],
            ),
            ListItemProgressText(progressText: progressText),
            Spacer(),
            ListItemNextAiringEpisode(
                isAiring: isAiring,
                nextEpisode: nextEpisode,
                airingAtDifference: airingAtDifference),
            ListItemProgress(
              isLoading: isLoading,
              nextEpisodeProgress: nextEpisodeProgress,
              progressPercentage: progressPercentage,
            ),
          ],
        ),
      ),
    );
  }
}
