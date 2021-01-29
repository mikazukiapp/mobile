import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/MediaType.dart';

part 'GetStaffMember.interface.g.dart';

@JsonSerializable(includeIfNull: false)
class IGetStaffMember {
  final int id;
  AniListMediaType type;
  bool onList;

  IGetStaffMember({
    this.id,
    this.type,
    this.onList,
  });

  factory IGetStaffMember.fromJson(Map<String, dynamic> json) =>
      _$IGetStaffMemberFromJson(json);
  Map<String, dynamic> toJson() => _$IGetStaffMemberToJson(this);
}
