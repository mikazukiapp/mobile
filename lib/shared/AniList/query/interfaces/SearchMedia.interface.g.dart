// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SearchMedia.interface.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ISearchMedia _$ISearchMediaFromJson(Map<String, dynamic> json) {
  return ISearchMedia(
    query: json['query'] as String,
    type: _$enumDecodeNullable(_$AniListMediaTypeEnumMap, json['type']),
    genres: (json['genres'] as List)?.map((e) => e as String)?.toList(),
    onList: json['onList'] as bool,
    isAdult: json['isAdult'] as bool,
  );
}

Map<String, dynamic> _$ISearchMediaToJson(ISearchMedia instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('query', instance.query);
  writeNotNull('type', _$AniListMediaTypeEnumMap[instance.type]);
  writeNotNull('genres', instance.genres);
  writeNotNull('onList', instance.onList);
  writeNotNull('isAdult', instance.isAdult);
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

const _$AniListMediaTypeEnumMap = {
  AniListMediaType.Anime: 'ANIME',
  AniListMediaType.Manga: 'MANGA',
};
