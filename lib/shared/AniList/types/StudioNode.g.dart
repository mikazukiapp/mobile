// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StudioNode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniListStudioNode _$AniListStudioNodeFromJson(Map<String, dynamic> json) {
  return AniListStudioNode(
    id: json['id'] as int,
    name: json['name'] as String,
    isAnimationStudio: json['isAnimationStudio'] as bool,
    siteUrl: json['siteUrl'] as String,
  );
}

Map<String, dynamic> _$AniListStudioNodeToJson(AniListStudioNode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isAnimationStudio': instance.isAnimationStudio,
      'siteUrl': instance.siteUrl,
    };
