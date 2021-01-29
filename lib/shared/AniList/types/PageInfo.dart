import 'package:json_annotation/json_annotation.dart';

part 'PageInfo.g.dart';

@JsonSerializable()
class AniListPageInfo {
  final int total;
  final int perPage;
  final int currentPage;
  final int lastPage;
  final bool hasNextPage;

  AniListPageInfo({
    this.total,
    this.perPage,
    this.currentPage,
    this.lastPage,
    this.hasNextPage,
  });

  factory AniListPageInfo.fromJson(Map<String, dynamic> json) =>
      _$AniListPageInfoFromJson(json);
  Map<String, dynamic> toJson() => _$AniListPageInfoToJson(this);
}
