import 'package:json_annotation/json_annotation.dart';

enum AniListMediaStatus {
  @JsonValue('CANCELLED')
  Cancelled,
  @JsonValue('FINISHED')
  Finished,
  @JsonValue('NOT_YET_RELEASED')
  NotYetReleased,
  @JsonValue('RELEASING')
  Releasing,
}
