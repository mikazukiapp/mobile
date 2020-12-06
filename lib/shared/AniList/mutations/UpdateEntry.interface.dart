import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/DateInput.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

part 'UpdateEntry.interface.g.dart';

@JsonSerializable(includeIfNull: false)
class IUpdateEntry {
  final int entryId;
  int progress;
  double score;
  AniListUserListStatus status;
  AniListDateInput startedAt;
  AniListDateInput completedAt;

  IUpdateEntry({
    this.entryId,
    this.progress,
    this.score,
    this.status,
    this.startedAt,
    this.completedAt,
  });

  factory IUpdateEntry.fromJson(Map<String, dynamic> json) => _$IUpdateEntryFromJson(json);
  Map<String, dynamic> toJson() => _$IUpdateEntryToJson(this);
}
