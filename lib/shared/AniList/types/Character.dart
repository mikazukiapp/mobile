import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/CharacterName.dart';
import 'package:mikazuki/shared/AniList/types/MediaConnection.dart';

part 'Character.g.dart';

@JsonSerializable()
class AniListCharacter {
  final AniListCharacterName name;
  final AniListMediaConnection media;

  AniListCharacter({
    this.name,
    this.media,
  });

  factory AniListCharacter.fromJson(Map<String, dynamic> json) =>
      _$AniListCharacterFromJson(json);
  Map<String, dynamic> toJson() => _$AniListCharacterToJson(this);
}
