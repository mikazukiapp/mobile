import 'package:json_annotation/json_annotation.dart';

part 'StaffName.g.dart';

@JsonSerializable()
class AniListStaffName {
  final String first;
  final String last;
  final String full;
  final String native;
  final List<String> alternative;

  AniListStaffName({
    this.first,
    this.last,
    this.full,
    this.native,
    this.alternative,
  });

  factory AniListStaffName.fromJson(Map<String, dynamic> json) =>
      _$AniListStaffNameFromJson(json);
  Map<String, dynamic> toJson() => _$AniListStaffNameToJson(this);
}
