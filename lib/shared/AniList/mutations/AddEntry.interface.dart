import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

part 'AddEntry.interface.g.dart';

@JsonSerializable(includeIfNull: false)
class IAddEntry {
  final int mediaId;
  final AniListUserListStatus status;
  int progress;
  int progressVolumes;
  double score;

  IAddEntry({
    this.mediaId,
    this.status,
    this.progress,
    this.progressVolumes,
    this.score,
  });

  factory IAddEntry.fromJson(Map<String, dynamic> json) => _$IAddEntryFromJson(json);
  Map<String, dynamic> toJson() => _$IAddEntryToJson(this);
}
