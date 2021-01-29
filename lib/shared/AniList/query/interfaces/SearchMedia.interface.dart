import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/MediaType.dart';

part 'SearchMedia.interface.g.dart';

@JsonSerializable(includeIfNull: false)
class ISearchMedia {
  final String query;
  AniListMediaType type;
  List<String> genres;
  bool onList;
  bool isAdult;

  ISearchMedia({
    this.query,
    this.type,
    this.genres,
    this.onList,
    this.isAdult,
  });

  factory ISearchMedia.fromJson(Map<String, dynamic> json) =>
      _$ISearchMediaFromJson(json);
  Map<String, dynamic> toJson() => _$ISearchMediaToJson(this);
}
