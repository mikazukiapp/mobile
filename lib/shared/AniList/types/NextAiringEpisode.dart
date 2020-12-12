import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NextAiringEpisode.g.dart';

@JsonSerializable()
class AniListNextAiringEpisode {
  final int airingAt;
  final int timeUntilAiring;
  final int episode;

  AniListNextAiringEpisode({
    this.airingAt,
    this.timeUntilAiring,
    this.episode,
  });

  DateTime get airingAtDateTime {
    return DateTime.fromMillisecondsSinceEpoch(this.airingAt * 1000);
  }

  Duration get airingAtDuration {
    final now = DateTime.now();
    return airingAtDateTime.difference(now);
  }

  String get airingAtDifference {
    final inDays = this.airingAtDuration.inDays;
    final inHours = this.airingAtDuration.inHours;
    final inMinutes = this.airingAtDuration.inMinutes;

    if (inDays > 1) {
      return '$inDays days';
    } else if (inDays == 1) {
      return '$inDays day';
    }

    if (inHours > 1) {
      return '$inHours hours';
    } else if (inHours == 1) {
      return '$inHours hour';
    }

    if (inMinutes > 1) {
      return '$inMinutes minutes';
    } else if (inMinutes == 1) {
      return '$inMinutes minute';
    }

    return 'now';
  }

  factory AniListNextAiringEpisode.fromJson(Map<String, dynamic> json) => _$AniListNextAiringEpisodeFromJson(json);
  Map<String, dynamic> toJson() => _$AniListNextAiringEpisodeToJson(this);
}
