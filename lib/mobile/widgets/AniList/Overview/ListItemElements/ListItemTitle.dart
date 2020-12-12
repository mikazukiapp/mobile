import 'package:flutter/material.dart';

class ListItemTitle extends StatelessWidget {
  const ListItemTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        semanticsLabel: title,
      )
    );
  }
}
