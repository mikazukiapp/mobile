// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserAvatar.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AniListUserAvatarAdapter extends TypeAdapter<AniListUserAvatar> {
  @override
  final int typeId = 0;

  @override
  AniListUserAvatar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AniListUserAvatar(
      large: fields[0] as String,
      medium: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AniListUserAvatar obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.large)
      ..writeByte(1)
      ..write(obj.medium);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AniListUserAvatarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HiveAniListUserAvatarAdapter extends TypeAdapter<HiveAniListUserAvatar> {
  @override
  final int typeId = 0;

  @override
  HiveAniListUserAvatar read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveAniListUserAvatar()
      ..large = fields[0] as String
      ..medium = fields[1] as String;
  }

  @override
  void write(BinaryWriter writer, HiveAniListUserAvatar obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.large)
      ..writeByte(1)
      ..write(obj.medium);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveAniListUserAvatarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AniListUserAvatar _$AniListUserAvatarFromJson(Map<String, dynamic> json) {
  return AniListUserAvatar(
    large: json['large'] as String,
    medium: json['medium'] as String,
  );
}

Map<String, dynamic> _$AniListUserAvatarToJson(AniListUserAvatar instance) =>
    <String, dynamic>{
      'large': instance.large,
      'medium': instance.medium,
    };
