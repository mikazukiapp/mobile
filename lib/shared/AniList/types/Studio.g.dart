// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Studio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniListStudio _$AniListStudioFromJson(Map<String, dynamic> json) {
  return AniListStudio(
    nodes: (json['nodes'] as List)
        ?.map((e) => e == null
            ? null
            : AniListStudioNode.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AniListStudioToJson(AniListStudio instance) =>
    <String, dynamic>{
      'nodes': instance.nodes,
    };
