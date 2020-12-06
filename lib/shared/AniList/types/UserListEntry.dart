import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/DateInput.dart';
import 'package:mikazuki/shared/AniList/types/Media.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

part 'UserListEntry.g.dart';

@JsonSerializable()
class AniListUserListEntry {
  final int id;
  final int progress;
  final AniListUserListStatus status;
  final double score;
  final int updatedAt; // Timestamp
  final AniListMedia media;
  final AniListDateInput startedAt;
  final AniListDateInput completedAt;

  AniListUserListEntry({
    this.id,
    this.progress,
    this.status,
    this.score,
    this.updatedAt,
    this.media,
    this.startedAt,
    this.completedAt,
  });

  factory AniListUserListEntry.fromJson(Map<String, dynamic> json) => _$AniListUserListEntryFromJson(json);
  Map<String, dynamic> toJson() => _$AniListUserListEntryToJson(this);

  // factory AniListUserListEntry.fromJson(Map<String, dynamic> json) {
  //   return AniListUserListEntry(
  //     id: json['id'] ?? null,
  //     progress: json['progress'] ?? null,
  //     score: json['score'].toDouble() ?? null,
  //     updatedAt: json['updatedAt'] ?? null,
  //     status: getAniListUserListStatusByJsonValue(json['status']),
  //     media: AniListMedia.fromJson(json['media'] ?? {}),
  //   );
  // }
}
