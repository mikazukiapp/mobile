import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/MediaType.dart';

part 'SearchCharacter.interface.g.dart';

@JsonSerializable(includeIfNull: false)
class ISearchCharacter {
  final String query;
  AniListMediaType type;
  bool onList;

  ISearchCharacter({
    this.query,
    this.type,
    this.onList,
  });

  factory ISearchCharacter.fromJson(Map<String, dynamic> json) =>
      _$ISearchCharacterFromJson(json);
  Map<String, dynamic> toJson() => _$ISearchCharacterToJson(this);
}
