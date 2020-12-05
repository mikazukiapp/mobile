import 'package:graphql/client.dart';
import 'package:json_annotation/json_annotation.dart';

enum AniListMediaType {
  @JsonValue('ANIME') Anime,
  @JsonValue('MANGA') Manga,
}

AniListMediaType getAniListMediaTypeByString(String type) {
  switch (type.toUpperCase()) {
    case 'ANIME':
      return AniListMediaType.Anime;
    case 'MANGA':
      return AniListMediaType.Manga;
    default:
      return null;
  }
}
