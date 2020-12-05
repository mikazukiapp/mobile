import 'package:json_annotation/json_annotation.dart';

@JsonKey(name: 'status')
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

AniListUserListStatus getAniListUserListStatusByJsonValue(String value) {
  switch (value.toUpperCase()) {
    case 'COMPLETED':
      return AniListUserListStatus.Completed;
    case 'PLANNING':
      return AniListUserListStatus.Planning;
    case 'DROPPED':
      return AniListUserListStatus.Dropped;
    case 'CURRENT':
      return AniListUserListStatus.Current;
    case 'PAUSED':
      return AniListUserListStatus.Paused;
    case 'REPEATING':
      return AniListUserListStatus.Repeating;
    default:
      return null;
  }
}

String getStringifiedAniListUserListStatus(AniListUserListStatus status) {
  switch (status) {
    case AniListUserListStatus.Completed:
      return 'COMPLETED';
    case AniListUserListStatus.Planning:
      return 'PLANNING';
    case AniListUserListStatus.Dropped:
      return 'DROPPED';
    case AniListUserListStatus.Current:
      return 'CURRENT';
    case AniListUserListStatus.Paused:
      return 'PAUSED';
    case AniListUserListStatus.Repeating:
      return 'REPEATING';
    default:
      return null;
  }
}
