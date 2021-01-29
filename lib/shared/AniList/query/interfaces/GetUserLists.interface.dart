import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/MediaType.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

part 'GetUserLists.interface.g.dart';

@JsonSerializable(includeIfNull: false)
class IGetUserLists {
  final String userName;
  AniListMediaType type;
  List<AniListUserListStatus> status;

  IGetUserLists({
    this.userName,
    this.type,
    this.status,
  });

  factory IGetUserLists.fromJson(Map<String, dynamic> json) =>
      _$IGetUserListsFromJson(json);
  Map<String, dynamic> toJson() => _$IGetUserListsToJson(this);
}
