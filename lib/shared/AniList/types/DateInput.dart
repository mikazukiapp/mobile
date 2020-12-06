import 'package:json_annotation/json_annotation.dart';

part 'DateInput.g.dart';

@JsonSerializable()
class AniListDateInput {
  final int year;
  final int month;
  final int day;

  AniListDateInput({
    this.year,
    this.month,
    this.day,
  });

  factory AniListDateInput.fromJson(Map<String, dynamic> json) => _$AniListDateInputFromJson(json);
  Map<String, dynamic> toJson() => _$AniListDateInputToJson(this);
}
