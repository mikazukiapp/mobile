// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Media.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniListMedia _$AniListMediaFromJson(Map<String, dynamic> json) {
  return AniListMedia(
    id: json['id'] as int,
    episodes: json['episodes'] as int,
    coverImage: json['coverImage'] == null
        ? null
        : AniListCoverImage.fromJson(
            json['coverImage'] as Map<String, dynamic>),
    title: json['title'] == null
        ? null
        : AniListTitle.fromJson(json['title'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AniListMediaToJson(AniListMedia instance) =>
    <String, dynamic>{
      'id': instance.id,
      'episodes': instance.episodes,
      'coverImage': instance.coverImage,
      'title': instance.title,
    };
