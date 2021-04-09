import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/search/baseResultItem.dart';
import 'package:mikazuki/shared/AniList/types/Staff.dart';

class StaffSearchResultItemWidget extends BaseSearchResultItemWidget {
  StaffSearchResultItemWidget(this.item, {Key key}) : super(key: key);
  final AniListStaff item;

  String get statusLine {
    return this.item.deformattedDescription ?? 'No description';
  }

  @override
  Widget build(BuildContext context) {
    return this.baseContainer(context, <Widget>[
      this.heroImage(context, item.id, item.image.large),
      this.textContainer(
        context,
        item.name.full,
        titleMaxLines: 1,
        statusLine: statusLine,
        statusLineMaxLines: 4,
      ),
    ]);
  }
}
