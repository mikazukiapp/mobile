import 'package:json_annotation/json_annotation.dart';

part 'StaffImage.g.dart';

@JsonSerializable()
class AniListStaffImage {
  final String large;
  final String medium;

  AniListStaffImage({
    this.large,
    this.medium,
  });

  factory AniListStaffImage.fromJson(Map<String, dynamic> json) =>
      _$AniListStaffImageFromJson(json);
  Map<String, dynamic> toJson() => _$AniListStaffImageToJson(this);
}
