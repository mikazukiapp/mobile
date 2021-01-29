import 'package:json_annotation/json_annotation.dart';

enum AniListMediaType {
  @JsonValue('ANIME')
  Anime,
  @JsonValue('MANGA')
  Manga,
}
