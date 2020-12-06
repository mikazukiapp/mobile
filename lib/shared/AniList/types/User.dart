import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class AniListUser {
  final int id;
  final String name;

  AniListUser({
    this.id,
    this.name,
  });

  factory AniListUser.fromJson(Map<String, dynamic> json) => _$AniListUserFromJson(json);
  Map<String, dynamic> toJson() => _$AniListUserToJson(this);
}
