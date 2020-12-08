import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/CoverImage.dart';
import 'package:mikazuki/shared/AniList/types/MediaStatus.dart';
import 'package:mikazuki/shared/AniList/types/MediaType.dart';
import 'package:mikazuki/shared/AniList/types/NextAiringEpisode.dart';
import 'package:mikazuki/shared/AniList/types/Title.dart';

part 'Media.g.dart';

@JsonSerializable()
class AniListMedia {
  final int id;
  final int episodes;
  final AniListMediaType type;
  final AniListCoverImage coverImage;
  final AniListTitle title;
  final AniListNextAiringEpisode nextAiringEpisode;
  final AniListMediaStatus status;

  AniListMedia({
    this.id,
    this.episodes,
    this.type,
    this.status,
    this.coverImage,
    this.title,
    this.nextAiringEpisode,
  });

  factory AniListMedia.fromJson(Map<String, dynamic> json) => _$AniListMediaFromJson(json);
  Map<String, dynamic> toJson() => _$AniListMediaToJson(this);
}
