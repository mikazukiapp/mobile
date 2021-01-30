import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/Character.dart';
import 'package:mikazuki/shared/AniList/types/CharacterRole.dart';
import 'package:mikazuki/shared/AniList/types/Media.dart';
import 'package:mikazuki/shared/AniList/types/Staff.dart';

part 'MediaEdge.g.dart';

@JsonSerializable()
class AniListMediaEdge {
  final AniListMedia node;
  final List<AniListStaff> voiceActors;
  final AniListCharacterRole characterRole;
  final List<AniListCharacter> characters;

  AniListMediaEdge(
      {this.node, this.voiceActors, this.characterRole, this.characters});

  factory AniListMediaEdge.fromJson(Map<String, dynamic> json) =>
      _$AniListMediaEdgeFromJson(json);
  Map<String, dynamic> toJson() => _$AniListMediaEdgeToJson(this);
}
