import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/StudioNode.dart';

part 'Studio.g.dart';

@JsonSerializable()
class AniListStudio {
  final List<AniListStudioNode> nodes;

  AniListStudio({this.nodes});

  factory AniListStudio.fromJson(Map<String, dynamic> json) =>
      _$AniListStudioFromJson(json);
  Map<String, dynamic> toJson() => _$AniListStudioToJson(this);
}
