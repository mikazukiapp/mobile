import 'package:json_annotation/json_annotation.dart';

part 'CharacterName.g.dart';

@JsonSerializable()
class AniListCharacterName {
  final String first;
  final String last;
  final String full;
  final String native;
  final List<String> alternative;

  AniListCharacterName({
    this.first,
    this.last,
    this.full,
    this.native,
    this.alternative,
  });

  factory AniListCharacterName.fromJson(Map<String, dynamic> json) =>
      _$AniListCharacterNameFromJson(json);
  Map<String, dynamic> toJson() => _$AniListCharacterNameToJson(this);
}
