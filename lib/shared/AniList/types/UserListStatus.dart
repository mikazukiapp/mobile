import 'package:json_annotation/json_annotation.dart';

enum AniListUserListStatus {
  @JsonValue('COMPLETED')
  Completed,
  @JsonValue('PLANNING')
  Planning,
  @JsonValue('DROPPED')
  Dropped,
  @JsonValue('CURRENT')
  Current,
  @JsonValue('PAUSED')
  Paused,
  @JsonValue('REPEATING')
  Repeating,
}
