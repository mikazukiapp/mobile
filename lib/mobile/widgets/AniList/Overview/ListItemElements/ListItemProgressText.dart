import 'package:flutter/material.dart';

class ListItemProgressText extends StatelessWidget {
  const ListItemProgressText({
    Key key,
    @required this.progressText,
  }) : super(key: key);

  final String progressText;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Episode $progressText',
      maxLines: 1,
      style: TextStyle(
        color: Colors.white70,
        fontSize: 12.0,
      ),
    );
  }
}
