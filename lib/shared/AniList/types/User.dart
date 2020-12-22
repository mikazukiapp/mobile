import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/UserAvatar.dart';

part 'User.g.dart';

@JsonSerializable()
class AniListUser {
  final int id;
  final String name;
  final AniListUserAvatar avatar;
  final String bannerImage;

  AniListUser({
    this.id,
    this.name,
    this.avatar,
    this.bannerImage,
  });

  factory AniListUser.fromJson(Map<String, dynamic> json) =>
      _$AniListUserFromJson(json);
  Map<String, dynamic> toJson() => _$AniListUserToJson(this);
}
