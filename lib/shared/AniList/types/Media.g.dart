// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniListMedia _$AniListMediaFromJson(Map<String, dynamic> json) {
  return AniListMedia(
    id: json['id'] as int,
    episodes: json['episodes'] as int,
    type: _$enumDecodeNullable(_$AniListMediaTypeEnumMap, json['type']),
    status: _$enumDecodeNullable(_$AniListMediaStatusEnumMap, json['status']),
    coverImage: json['coverImage'] == null
        ? null
        : AniListCoverImage.fromJson(
            json['coverImage'] as Map<String, dynamic>),
    title: json['title'] == null
        ? null
        : AniListTitle.fromJson(json['title'] as Map<String, dynamic>),
    nextAiringEpisode: json['nextAiringEpisode'] == null
        ? null
        : AniListNextAiringEpisode.fromJson(
            json['nextAiringEpisode'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AniListMediaToJson(AniListMedia instance) =>
    <String, dynamic>{
      'id': instance.id,
      'episodes': instance.episodes,
      'type': _$AniListMediaTypeEnumMap[instance.type],
      'coverImage': instance.coverImage,
      'title': instance.title,
      'nextAiringEpisode': instance.nextAiringEpisode,
      'status': _$AniListMediaStatusEnumMap[instance.status],
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

const _$AniListMediaTypeEnumMap = {
  AniListMediaType.Anime: 'ANIME',
  AniListMediaType.Manga: 'MANGA',
};

const _$AniListMediaStatusEnumMap = {
  AniListMediaStatus.Cancelled: 'CANCELLED',
  AniListMediaStatus.Finished: 'FINISHED',
  AniListMediaStatus.NotYetReleased: 'NOT_YET_RELEASED',
  AniListMediaStatus.Releasing: 'RELEASING',
};
