import 'package:flutter/material.dart';

class ListItemScore extends StatelessWidget {
  const ListItemScore({
    Key key,
    @required this.score,
  }) : super(key: key);

  final double score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            score.toStringAsFixed(1) ?? '---',
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          Icon(
            Icons.star,
            size: 12.0,
          ),
        ],
      ),
    );
  }
}
