// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniListMedia _$AniListMediaFromJson(Map<String, dynamic> json) {
  return AniListMedia(
    id: json['id'] as int,
    episodes: json['episodes'] as int,
    chapters: json['chapters'] as int,
    volumes: json['volumes'] as int,
    averageScore: json['averageScore'] as int,
    meanScore: json['meanScore'] as int,
    type: _$enumDecodeNullable(_$AniListMediaTypeEnumMap, json['type']),
    format: _$enumDecodeNullable(_$AniListMediaFormatEnumMap, json['format']),
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
      'chapters': instance.chapters,
      'volumes': instance.volumes,
      'averageScore': instance.averageScore,
      'meanScore': instance.meanScore,
      'type': _$AniListMediaTypeEnumMap[instance.type],
      'format': _$AniListMediaFormatEnumMap[instance.format],
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

const _$AniListMediaFormatEnumMap = {
  AniListMediaFormat.TV: 'TV',
  AniListMediaFormat.TVShort: 'TV_SHORT',
  AniListMediaFormat.Movie: 'MOVIE',
  AniListMediaFormat.Special: 'SPECIAL',
  AniListMediaFormat.OVA: 'OVA',
  AniListMediaFormat.ONA: 'ONA',
  AniListMediaFormat.Music: 'MUSIC',
  AniListMediaFormat.Manga: 'MANGA',
  AniListMediaFormat.Novel: 'NOVEL',
  AniListMediaFormat.OneShot: 'ONE_SHOT',
};

const _$AniListMediaStatusEnumMap = {
  AniListMediaStatus.Cancelled: 'CANCELLED',
  AniListMediaStatus.Finished: 'FINISHED',
  AniListMediaStatus.NotYetReleased: 'NOT_YET_RELEASED',
  AniListMediaStatus.Releasing: 'RELEASING',
};
