import 'package:json_annotation/json_annotation.dart';

enum AniListMediaFormat {
  @JsonValue('TV')
  TV,
  @JsonValue('TV_SHORT')
  TVShort,
  @JsonValue('MOVIE')
  Movie,
  @JsonValue('SPECIAL')
  Special, // DVD/Blu-ray exclusive specials (Picture Dramas etc.)
  @JsonValue('OVA')
  OVA, // DVD/Blu-ray releases
  @JsonValue('ONA')
  ONA, // Original Net Anime (online-only)
  @JsonValue('MUSIC')
  Music, // Short anime released as music video
  @JsonValue('MANGA')
  Manga,
  @JsonValue('NOVEL')
  Novel,
  @JsonValue('ONE_SHOT')
  OneShot,
}
