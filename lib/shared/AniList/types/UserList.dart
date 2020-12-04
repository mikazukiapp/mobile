import 'package:mikazuki/shared/AniList/types/UserListEntry.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

class AniListUserList {
  final String name;
  final AniListUserListStatus status;
  final List<AniListUserListEntry> entries;

  AniListUserList({
    this.name,
    this.status,
    this.entries,
  });

  factory AniListUserList.fromJson(Map<String, dynamic> json) {
    final List<AniListUserListEntry> entries = [];
    (json['entries'] ?? []).forEach((element) {
      entries.add(AniListUserListEntry.fromJson(element));
    });

    return AniListUserList(
      name: json['name'] ?? null,
      status: getAniListUserListStatusByJsonValue(json['status']),
      entries: entries,
    );
  }

  @override
  String toString() {
    return [this.name, ...this.entries.map((entry) => entry.media.title.romaji)].join(', ');
  }
}
