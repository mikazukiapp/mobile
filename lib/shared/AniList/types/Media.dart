import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/CoverImage.dart';
import 'package:mikazuki/shared/AniList/types/Format.dart';
import 'package:mikazuki/shared/AniList/types/MediaStatus.dart';
import 'package:mikazuki/shared/AniList/types/MediaType.dart';
import 'package:mikazuki/shared/AniList/types/NextAiringEpisode.dart';
import 'package:mikazuki/shared/AniList/types/Title.dart';
import 'package:mikazuki/shared/AniList/types/UserListEntry.dart';

part 'Media.g.dart';

@JsonSerializable()
class AniListMedia {
  final int id;
  final int episodes;
  final int chapters;
  final int volumes;
  final int averageScore;
  final int meanScore;
  final AniListMediaType type;
  final AniListMediaFormat format;
  final AniListCoverImage coverImage;
  final AniListTitle title;
  final AniListNextAiringEpisode nextAiringEpisode;
  final AniListMediaStatus status;
  @JsonKey(ignore: true)
  AniListUserListEntry mediaListEntry;

  AniListMedia({
    this.id,
    this.episodes,
    this.chapters,
    this.volumes,
    this.averageScore,
    this.meanScore,
    this.type,
    this.format,
    this.status,
    this.coverImage,
    this.title,
    this.nextAiringEpisode,
  });

  String get statusTitle {
    switch (this.status) {
      case AniListMediaStatus.Cancelled:
        return 'Cancelled';
      case AniListMediaStatus.Finished:
        return 'Finished';
      case AniListMediaStatus.NotYetReleased:
        return 'Not yet released';
      case AniListMediaStatus.Releasing:
        return 'Releasing';
      default:
        return 'Status unknown';
    }
  }

  factory AniListMedia.fromJson(Map<String, dynamic> json) =>
      _$AniListMediaFromJson(json);
  Map<String, dynamic> toJson() => _$AniListMediaToJson(this);
}
