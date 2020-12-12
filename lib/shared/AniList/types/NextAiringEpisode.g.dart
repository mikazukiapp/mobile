// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NextAiringEpisode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniListNextAiringEpisode _$AniListNextAiringEpisodeFromJson(
    Map<String, dynamic> json) {
  return AniListNextAiringEpisode(
    airingAt: json['airingAt'] as int,
    timeUntilAiring: json['timeUntilAiring'] as int,
    episode: json['episode'] as int,
  );
}

Map<String, dynamic> _$AniListNextAiringEpisodeToJson(
        AniListNextAiringEpisode instance) =>
    <String, dynamic>{
      'airingAt': instance.airingAt,
      'timeUntilAiring': instance.timeUntilAiring,
      'episode': instance.episode,
    };
