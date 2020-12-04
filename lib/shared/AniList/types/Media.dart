import 'package:mikazuki/shared/AniList/types/CoverImage.dart';
import 'package:mikazuki/shared/AniList/types/Title.dart';

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

  factory AniListMedia.fromJson(Map<String, dynamic> json) {
    return AniListMedia(
      id: json['id'] ?? null,
      episodes: json['episodes'] ?? null,
      coverImage: AniListCoverImage.fromJson(json['coverImage'] ?? {}),
      title: AniListTitle.fromJson(json['title'] ?? {}),
    );
  }
}
