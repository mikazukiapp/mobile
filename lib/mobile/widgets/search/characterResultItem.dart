import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/search/baseResultItem.dart';
import 'package:mikazuki/shared/AniList/types/Character.dart';
import 'package:mikazuki/shared/AniList/types/Media.dart';
import 'package:mikazuki/shared/AniList/types/Staff.dart';
import 'package:mikazuki/shared/AniList/types/StaffLanguage.dart';

class CharacterSearchResultItemWidget extends BaseSearchResultItemWidget {
  const CharacterSearchResultItemWidget(this.item, {Key key}) : super(key: key);
  final AniListCharacter item;

  List<AniListStaff> get japaneseVoiceActor {
    if (item.media.edges.isEmpty) {
      return null;
    }

    var edge = item.media.edges.firstWhere(
        (element) => element.voiceActors.isNotEmpty,
        orElse: () => null);

    if (edge == null) {
      return null;
    }

    return edge.voiceActors
        .where((element) => element.language == AniListStaffLanguage.Japanese)
        .toList();
  }

  AniListMedia get firstMediaElement {
    if (item.media.edges.isEmpty) {
      return null;
    }

    var edge = item.media.edges.firstWhere(
        (element) => element.voiceActors.isNotEmpty,
        orElse: () => null);

    if (edge == null) {
      return null;
    }

    return edge.node;
  }

  String get statusLine {
    if (japaneseVoiceActor == null) {
      return '';
    }

    return 'Japanese Voice actor: ${japaneseVoiceActor.map((element) => element.name.full).toList().join(', ')}';
  }

  String get bottomLine {
    if (firstMediaElement == null) {
      return '';
    }

    return 'Appears in: ${firstMediaElement?.title?.userPreferred}';
  }

  @override
  Widget build(BuildContext context) {
    return this.baseContainer(context, <Widget>[
      this.heroImage(context, item.id, item.image.large),
      this.textContainer(
        context,
        item.name.full,
        titleMaxLines: 1,
        statusLine: bottomLine,
        statusLineMaxLines: 3,
        bottomLine: statusLine,
        bottomLineMaxLines: 1,
      ),
    ]);
  }
}
