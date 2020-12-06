// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Title.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniListTitle _$AniListTitleFromJson(Map<String, dynamic> json) {
  return AniListTitle(
    romaji: json['romaji'] as String,
    english: json['english'] as String,
    native: json['native'] as String,
    userPreferred: json['userPreferred'] as String,
  );
}

Map<String, dynamic> _$AniListTitleToJson(AniListTitle instance) =>
    <String, dynamic>{
      'romaji': instance.romaji,
      'english': instance.english,
      'native': instance.native,
      'userPreferred': instance.userPreferred,
    };
