import 'package:json_annotation/json_annotation.dart';

part 'SearchStaff.interface.g.dart';

@JsonSerializable(includeIfNull: false)
class ISearchStaff {
  final String query;
  bool onList;

  ISearchStaff({
    this.query,
    this.onList,
  });

  factory ISearchStaff.fromJson(Map<String, dynamic> json) =>
      _$ISearchStaffFromJson(json);
  Map<String, dynamic> toJson() => _$ISearchStaffToJson(this);
}
