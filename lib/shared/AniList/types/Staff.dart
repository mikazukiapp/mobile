import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/types/MediaConnection.dart';
import 'package:mikazuki/shared/AniList/types/StaffImage.dart';
import 'package:mikazuki/shared/AniList/types/StaffLanguage.dart';
import 'package:mikazuki/shared/AniList/types/StaffName.dart';

part 'Staff.g.dart';

@JsonSerializable()
class AniListStaff {
  final int id;
  final AniListStaffName name;
  final AniListStaffImage image;
  final AniListStaffLanguage language;
  final AniListMediaConnection characterMedia;
  final String description;

  AniListStaff({
    this.id,
    this.name,
    this.description,
    this.image,
    this.language,
    this.characterMedia,
  });

  String get deformattedDescription {
    return this
        .description
        // Replace all newlines that follow right after a underscore+space
        ?.replaceAll(new RegExp(r'__\s+\n-'), '')
        // Replace all underscores with emptyness
        ?.replaceAll(new RegExp(r'__'), '')
        // Replace all Markdown links
        ?.replaceAll(new RegExp(r'\[\w+\]\([\w\.\:\/_\-\+]+\)\s*\|?'), '')
        // Trim excess spaces
        ?.trim();
  }

  factory AniListStaff.fromJson(Map<String, dynamic> json) =>
      _$AniListStaffFromJson(json);
  Map<String, dynamic> toJson() => _$AniListStaffToJson(this);
}
