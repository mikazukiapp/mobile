import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/MediaEdge.dart';
import 'package:mikazuki/shared/AniList/types/PageInfo.dart';

part 'MediaConnection.g.dart';

@JsonSerializable()
class AniListMediaConnection {
  final List<AniListMediaEdge> edges;
  final AniListPageInfo pageInfo;

  AniListMediaConnection({this.edges, this.pageInfo});

  factory AniListMediaConnection.fromJson(Map<String, dynamic> json) =>
      _$AniListMediaConnectionFromJson(json);
  Map<String, dynamic> toJson() => _$AniListMediaConnectionToJson(this);
}
