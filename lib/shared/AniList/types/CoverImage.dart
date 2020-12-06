import 'package:json_annotation/json_annotation.dart';

part 'CoverImage.g.dart';

@JsonSerializable()
class AniListCoverImage {
  final String color;
  final String medium;
  final String large;
  final String extraLarge;

  AniListCoverImage({this.color, this.medium, this.large, this.extraLarge});

  String getSmallest() {
    return medium ?? large ?? extraLarge ?? null;
  }

  factory AniListCoverImage.fromJson(Map<String, dynamic> json) => _$AniListCoverImageFromJson(json);
  Map<String, dynamic> toJson() => _$AniListCoverImageToJson(this);

  // factory AniListCoverImage.fromJson(Map<String, dynamic> json) {
  //   return AniListCoverImage(
  //       color: json['color'] ?? null,
  //       medium: json['medium'] ?? null,
  //       large: json['large'] ?? null,
  //       extraLarge: json['extraLarge'] ?? null);
  // }
}
