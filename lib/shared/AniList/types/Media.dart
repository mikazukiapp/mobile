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
  final bool isAdult;
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
    this.isAdult,
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

  String get formatTitle {
    switch (this.format) {
      case AniListMediaFormat.Manga:
        return 'Manga';
      case AniListMediaFormat.Movie:
        return 'Movie';
      case AniListMediaFormat.Music:
        return 'Music video';
      case AniListMediaFormat.Novel:
        return 'Novel';
      case AniListMediaFormat.ONA:
        return 'ONA';
      case AniListMediaFormat.OVA:
        return 'OVA';
      case AniListMediaFormat.OneShot:
        return 'One Shot';
      case AniListMediaFormat.Special:
        return 'Special';
      case AniListMediaFormat.TV:
        return 'TV Anime';
      case AniListMediaFormat.TVShort:
        return 'Short TV Anime';
      default:
        return 'Format unknown';
    }
  }

  static bool isAnime(AniListMediaFormat format) {
    return [
      AniListMediaFormat.TV,
      AniListMediaFormat.TVShort,
      AniListMediaFormat.ONA,
      AniListMediaFormat.OVA,
      AniListMediaFormat.Movie,
      AniListMediaFormat.Special,
    ].contains(format);
  }

  static bool isBook(AniListMediaFormat format) {
    return [
      AniListMediaFormat.Manga,
      AniListMediaFormat.OneShot,
      AniListMediaFormat.Novel,
    ].contains(format);
  }

  static bool isMisc(AniListMediaFormat format) {
    return [
      AniListMediaFormat.Music,
    ].contains(format);
  }

  factory AniListMedia.fromJson(Map<String, dynamic> json) =>
      _$AniListMediaFromJson(json);
  Map<String, dynamic> toJson() => _$AniListMediaToJson(this);
}
