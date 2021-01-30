import 'package:flutter/material.dart';

abstract class BaseSearchResultItemWidget extends StatelessWidget {
  const BaseSearchResultItemWidget({Key key}) : super(key: key);

  Widget baseContainer(BuildContext context, List<Widget> children) {
    return Container(
      padding: EdgeInsets.only(bottom: 4.0, top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget heroImage(BuildContext context, dynamic tag, String imageSrc) {
    return Hero(
      tag: tag,
      child: SizedBox(
        width: 64.0,
        height: 96.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            imageSrc,
            fit: BoxFit.fitHeight,
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

  Widget textContainer(BuildContext context, String title,
      {String statusLine, String bottomLine, int titleMaxLines = 3}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        height: 96.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            this.titleText(context, title, titleMaxLines: titleMaxLines),
            if (statusLine.length > 0) infoText(context, statusLine),
            if (bottomLine.length > 0) infoText(context, bottomLine),
          ],
        ),
      ),
    );
  }

  Widget scoreContainer(BuildContext context, String score,
      {List<Widget> columnChildren}) {
    double progressValue = (double.tryParse(score) ?? 0) / 100;

    return Container(
      height: 96.0,
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (score != null)
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Center(
                  child: SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.transparent,
                      value: progressValue,
                      strokeWidth: 1.0,
                    ),
                  ),
                ),
                Text(
                  score,
                  style: TextStyle(
                    fontSize: 8.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          if (columnChildren != null) ...columnChildren,
        ],
      ),
    );
  }

  Widget titleText(BuildContext context, String title,
      {int titleMaxLines = 3}) {
    return Expanded(
      flex: 2,
      child: Text(
        title,
        maxLines: titleMaxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget infoText(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12.0,
      ),
    );
  }
}
