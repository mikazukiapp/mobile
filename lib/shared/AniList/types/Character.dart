import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/CharacterImage.dart';
import 'package:mikazuki/shared/AniList/types/CharacterName.dart';
import 'package:mikazuki/shared/AniList/types/MediaConnection.dart';

part 'Character.g.dart';

@JsonSerializable()
class AniListCharacter {
  final int id;
  final AniListCharacterName name;
  final AniListCharacterImage image;
  final AniListMediaConnection media;

  AniListCharacter({
    this.id,
    this.name,
    this.image,
    this.media,
  });

  factory AniListCharacter.fromJson(Map<String, dynamic> json) =>
      _$AniListCharacterFromJson(json);
  Map<String, dynamic> toJson() => _$AniListCharacterToJson(this);
}
