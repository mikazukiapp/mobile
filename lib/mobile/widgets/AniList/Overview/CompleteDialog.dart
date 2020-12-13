import 'package:flutter/material.dart';

class AniListCompleteDialog extends StatefulWidget {
  final String title;
  final bool isLoading;
  final double score;

  AniListCompleteDialog({Key key, this.title, this.isLoading, this.score})
      : super(key: key);

  @override
  _AniListCompleteDialogState createState() => _AniListCompleteDialogState();
}

class _AniListCompleteDialogState extends State<AniListCompleteDialog> {
  double _score;

  @override
  void initState() {
    super.initState();
    _score = widget.score;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Did you like ${widget.title}?'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('You can give a final score here.'),
          Slider.adaptive(
            value: _score,
            min: 0,
            max: 10.0,
            divisions: 20,
            label: '${_score.toStringAsFixed(1)}',
            onChanged: (double value) {
              setState(() => _score = value);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Selected score: ${_score.toStringAsFixed(1)}'),
              Icon(Icons.star, size: 16.0,),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        if (!widget.isLoading)
          FlatButton.icon(
            label: Text('Complete'),
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pop(_score);
            },
          ),
      ],
    );
  }
}
