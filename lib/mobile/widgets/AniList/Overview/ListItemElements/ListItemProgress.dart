import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/util/ExColor.dart';

class ListItemProgress extends StatelessWidget {
  const ListItemProgress({
    Key key,
    @required this.nextEpisodeProgress,
    @required this.progressPercentage,
    @required this.isLoading,
  }) : super(key: key);

  final double nextEpisodeProgress;
  final double progressPercentage;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      overflow: Overflow.visible,
      children: <Widget>[
        if (!isLoading)
          SizedBox(
            height: 6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2.0),
              child: LinearProgressIndicator(
                value: nextEpisodeProgress,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.green[200]),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        SizedBox(
          height: 6,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2.0),
            child: LinearProgressIndicator(
              value: !isLoading ? progressPercentage : null,
              valueColor: AlwaysStoppedAnimation<Color>(
                  ExColor.darken(Colors.green[500])),
              backgroundColor: ExColor.darken(
                  Colors.green[500].withOpacity(0.4)),
            ),
          ),
        ),
      ],
    );
  }
}
