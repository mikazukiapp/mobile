import 'package:json_annotation/json_annotation.dart';

part 'Title.g.dart';

@JsonSerializable()
class AniListTitle {
  final String romaji;
  final String english;
  final String native;
  final String userPreferred;

  AniListTitle({
    this.romaji,
    this.english,
    this.native,
    this.userPreferred,
  });

  factory AniListTitle.fromJson(Map<String, dynamic> json) => _$AniListTitleFromJson(json);
  Map<String, dynamic> toJson() => _$AniListTitleToJson(this);
}
