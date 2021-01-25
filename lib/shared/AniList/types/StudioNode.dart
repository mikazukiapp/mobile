import 'package:json_annotation/json_annotation.dart';

part 'StudioNode.g.dart';

@JsonSerializable()
class AniListStudioNode {
  final int id;
  final String name;
  final bool isAnimationStudio;
  final String siteUrl;

  AniListStudioNode({this.id, this.name, this.isAnimationStudio, this.siteUrl});

  factory AniListStudioNode.fromJson(Map<String, dynamic> json) =>
      _$AniListStudioNodeFromJson(json);
  Map<String, dynamic> toJson() => _$AniListStudioNodeToJson(this);
}
