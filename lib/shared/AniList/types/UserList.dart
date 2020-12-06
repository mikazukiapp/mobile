import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/UserListEntry.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

part 'UserList.g.dart';

@JsonSerializable()
class AniListUserList {
  final String name;
  final AniListUserListStatus status;
  final List<AniListUserListEntry> entries;

  AniListUserList({
    this.name,
    this.status,
    this.entries,
  });

  factory AniListUserList.fromJson(Map<String, dynamic> json) => _$AniListUserListFromJson(json);
  Map<String, dynamic> toJson() => _$AniListUserListToJson(this);

  @override
  String toString() {
    return [this.name, ...this.entries.map((entry) => entry.media.title.romaji)].join(', ');
  }
}
