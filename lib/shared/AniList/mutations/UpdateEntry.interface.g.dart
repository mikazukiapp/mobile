// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UpdateEntry.interface.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IUpdateEntry _$IUpdateEntryFromJson(Map<String, dynamic> json) {
  return IUpdateEntry(
    entryId: json['entryId'] as int,
    progress: json['progress'] as int,
    progressVolumes: json['progressVolumes'] as int,
    score: (json['score'] as num)?.toDouble(),
    status:
        _$enumDecodeNullable(_$AniListUserListStatusEnumMap, json['status']),
    startedAt: json['startedAt'] == null
        ? null
        : AniListDateInput.fromJson(json['startedAt'] as Map<String, dynamic>),
    completedAt: json['completedAt'] == null
        ? null
        : AniListDateInput.fromJson(
            json['completedAt'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$IUpdateEntryToJson(IUpdateEntry instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('entryId', instance.entryId);
  writeNotNull('progress', instance.progress);
  writeNotNull('progressVolumes', instance.progressVolumes);
  writeNotNull('score', instance.score);
  writeNotNull('status', _$AniListUserListStatusEnumMap[instance.status]);
  writeNotNull('startedAt', instance.startedAt);
  writeNotNull('completedAt', instance.completedAt);
  return val;
}

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
