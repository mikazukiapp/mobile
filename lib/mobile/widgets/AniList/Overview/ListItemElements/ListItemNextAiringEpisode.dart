import 'package:flutter/material.dart';

class ListItemNextAiringEpisode extends StatelessWidget {
  const ListItemNextAiringEpisode({
    Key key,
    @required this.isAiring,
    @required this.nextEpisode,
    @required this.airingAtDifference,
  }) : super(key: key);

  final bool isAiring;
  final int nextEpisode;
  final String airingAtDifference;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          if (isAiring)
            Flexible(
              flex: 1,
              child: Icon(
                Icons.settings_input_antenna,
                size: 12.0,
                color: Colors.green,
              ),
            ),
          if (nextEpisode != null)
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: isAiring ? 4.0 : 0),
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
    );
  }
}
