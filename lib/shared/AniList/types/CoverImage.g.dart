// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CoverImage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniListCoverImage _$AniListCoverImageFromJson(Map<String, dynamic> json) {
  return AniListCoverImage(
    color: json['color'] as String,
    medium: json['medium'] as String,
    large: json['large'] as String,
    extraLarge: json['extraLarge'] as String,
  );
}

Map<String, dynamic> _$AniListCoverImageToJson(AniListCoverImage instance) =>
    <String, dynamic>{
      'color': instance.color,
      'medium': instance.medium,
      'large': instance.large,
      'extraLarge': instance.extraLarge,
    };
