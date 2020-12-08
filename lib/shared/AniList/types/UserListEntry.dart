import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/DateInput.dart';
import 'package:mikazuki/shared/AniList/types/Media.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

part 'UserListEntry.g.dart';

@JsonSerializable()
class AniListUserListEntry {
  final int id;
  final int progress;
  final int progressVolumes;
  final AniListUserListStatus status;
  final double score;
  final int updatedAt; // Timestamp
  final AniListMedia media;
  final AniListDateInput startedAt;
  final AniListDateInput completedAt;

  AniListUserListEntry({
    this.id,
    this.progress,
    this.progressVolumes,
    this.status,
    this.score,
    this.updatedAt,
    this.media,
    this.startedAt,
    this.completedAt,
  });

  String get progressText {
    if (media?.episodes == null) {
      return '$progress / ?';
    }

    return '$progress / ${media.episodes}';
  }

  double get progressPercentage {
    if (progress == 0) {
      return 0;
    }

    if (media?.episodes != null) {
      return (progress / media.episodes).toDouble();
    }

    if (media?.nextAiringEpisode?.episode != null) {
      return (progress / media.nextAiringEpisode.episode / 100 * 75).toDouble();
    }

    return 0;
  }

  double get nextEpisodeProgressPercentage {
    if (media?.nextAiringEpisode?.episode == null) {
      return 0;
    }

    final episodesUntilNow = media.nextAiringEpisode.episode - 1;

    if (episodesUntilNow == 0) {
      return 0;
    }

    if (media?.episodes == null) {
      int multiplyer = progress == episodesUntilNow ? 75 : 80;

      return (progress / episodesUntilNow / 100 * multiplyer).toDouble();
    }

    return (episodesUntilNow / media.episodes).toDouble();
  }

  factory AniListUserListEntry.fromJson(Map<String, dynamic> json) => _$AniListUserListEntryFromJson(json);
  Map<String, dynamic> toJson() => _$AniListUserListEntryToJson(this);
}
