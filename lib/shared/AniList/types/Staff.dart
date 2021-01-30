import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/StaffLanguage.dart';
import 'package:mikazuki/shared/AniList/types/StaffName.dart';

part 'Staff.g.dart';

@JsonSerializable()
class AniListStaff {
  final int id;
  final AniListStaffName name;
  final AniListStaffLanguage language;

  AniListStaff({
    this.id,
    this.name,
    this.language,
  });

  factory AniListStaff.fromJson(Map<String, dynamic> json) =>
      _$AniListStaffFromJson(json);
  Map<String, dynamic> toJson() => _$AniListStaffToJson(this);
}
