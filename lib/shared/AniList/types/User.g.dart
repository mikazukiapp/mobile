// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'User.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniListUser _$AniListUserFromJson(Map<String, dynamic> json) {
  return AniListUser(
    id: json['id'] as int,
    name: json['name'] as String,
    avatar: json['avatar'] == null
        ? null
        : AniListUserAvatar.fromJson(json['avatar'] as Map<String, dynamic>),
    bannerImage: json['bannerImage'] as String,
  );
}

Map<String, dynamic> _$AniListUserToJson(AniListUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'bannerImage': instance.bannerImage,
    };
