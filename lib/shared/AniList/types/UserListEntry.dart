import 'package:mikazuki/shared/AniList/types/Media.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

class AniListUserListEntry {
  final int id;
  final int progress;
  final AniListUserListStatus status;
  final double score;
  final int updatedAt; // Timestamp
  final AniListMedia media;

  AniListUserListEntry({
    this.id,
    this.progress,
    this.status,
    this.score,
    this.updatedAt,
    this.media,
  });

  factory AniListUserListEntry.fromJson(Map<String, dynamic> json) {
    return AniListUserListEntry(
      id: json['id'] ?? null,
      progress: json['progress'] ?? null,
      score: json['score'].toDouble() ?? null,
      updatedAt: json['updatedAt'] ?? null,
      status: getAniListUserListStatusByJsonValue(json['status']),
      media: AniListMedia.fromJson(json['media'] ?? {}),
    );
  }
}
