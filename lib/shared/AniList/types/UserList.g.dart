// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniListUserList _$AniListUserListFromJson(Map<String, dynamic> json) {
  return AniListUserList(
    name: json['name'] as String,
    status:
        _$enumDecodeNullable(_$AniListUserListStatusEnumMap, json['status']),
    entries: (json['entries'] as List)
        ?.map((e) => e == null
            ? null
            : AniListUserListEntry.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AniListUserListToJson(AniListUserList instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': _$AniListUserListStatusEnumMap[instance.status],
      'entries': instance.entries,
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
