import 'package:json_annotation/json_annotation.dart';

enum AniListCharacterRole {
  @JsonValue('MAIN')
  Main,
  @JsonValue('SUPPORTING')
  Supporting,
  @JsonValue('BACKGROUND')
  Background,
}
