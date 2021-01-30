import 'package:json_annotation/json_annotation.dart';

part 'CharacterImage.g.dart';

@JsonSerializable()
class AniListCharacterImage {
  final String large;
  final String medium;

  AniListCharacterImage({
    this.large,
    this.medium,
  });

  factory AniListCharacterImage.fromJson(Map<String, dynamic> json) =>
      _$AniListCharacterImageFromJson(json);
  Map<String, dynamic> toJson() => _$AniListCharacterImageToJson(this);
}
