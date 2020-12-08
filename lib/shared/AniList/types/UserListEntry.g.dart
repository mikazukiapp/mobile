// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserListEntry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniListUserListEntry _$AniListUserListEntryFromJson(Map<String, dynamic> json) {
  return AniListUserListEntry(
    id: json['id'] as int,
    progress: json['progress'] as int,
    progressVolumes: json['progressVolumes'] as int,
    status:
        _$enumDecodeNullable(_$AniListUserListStatusEnumMap, json['status']),
    score: (json['score'] as num)?.toDouble(),
    updatedAt: json['updatedAt'] as int,
    media: json['media'] == null
        ? null
        : AniListMedia.fromJson(json['media'] as Map<String, dynamic>),
    startedAt: json['startedAt'] == null
        ? null
        : AniListDateInput.fromJson(json['startedAt'] as Map<String, dynamic>),
    completedAt: json['completedAt'] == null
        ? null
        : AniListDateInput.fromJson(
            json['completedAt'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AniListUserListEntryToJson(
        AniListUserListEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'progress': instance.progress,
      'progressVolumes': instance.progressVolumes,
      'status': _$AniListUserListStatusEnumMap[instance.status],
      'score': instance.score,
      'updatedAt': instance.updatedAt,
      'media': instance.media,
      'startedAt': instance.startedAt,
      'completedAt': instance.completedAt,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$AniListUserListStatusEnumMap = {
  AniListUserListStatus.Completed: 'COMPLETED',
  AniListUserListStatus.Planning: 'PLANNING',
  AniListUserListStatus.Dropped: 'DROPPED',
  AniListUserListStatus.Current: 'CURRENT',
  AniListUserListStatus.Paused: 'PAUSED',
  AniListUserListStatus.Repeating: 'REPEATING',
};
