import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserAvatar.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class AniListUserAvatar extends HiveObject {
  @HiveField(0)
  final String large;

  @HiveField(1)
  final String medium;

  AniListUserAvatar({this.large, this.medium});

  String getSmallest() {
    return medium ?? large ?? null;
  }

  factory AniListUserAvatar.fromJson(Map<String, dynamic> json) =>
      _$AniListUserAvatarFromJson(json);
  Map<String, dynamic> toJson() => _$AniListUserAvatarToJson(this);
}

@HiveType(typeId: 0)
class HiveAniListUserAvatar extends HiveObject {
  @HiveField(0)
  String large;

  @HiveField(1)
  String medium;
}
