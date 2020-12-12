import 'package:flutter/material.dart';

class ListItemHero extends StatelessWidget {
  const ListItemHero({
    Key key,
    @required this.entryId,
    @required this.coverImage,
  }) : super(key: key);

  final int entryId;
  final String coverImage;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: entryId,
      child: SizedBox(
        width: 64.0,
        height: 96.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            coverImage,
            fit: BoxFit.fitHeight,
            filterQuality: FilterQuality.high,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent loadingProgress) {
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
    );
  }
}
