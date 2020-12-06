import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/CoverImage.dart';
import 'package:mikazuki/shared/AniList/types/Title.dart';

part 'Media.g.dart';

@JsonSerializable()
class AniListMedia {
  final int id;
  final int episodes;
  final AniListCoverImage coverImage;
  final AniListTitle title;

  AniListMedia({
    this.id,
    this.episodes,
    this.coverImage,
    this.title,
  });

  factory AniListMedia.fromJson(Map<String, dynamic> json) => _$AniListMediaFromJson(json);
  Map<String, dynamic> toJson() => _$AniListMediaToJson(this);
}
