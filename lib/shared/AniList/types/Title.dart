class AniListTitle {
  final String romaji;
  final String english;
  final String native;
  final String userPreferred;

  AniListTitle({
    this.romaji,
    this.english,
    this.native,
    this.userPreferred,
  });

  factory AniListTitle.fromJson(Map<String, dynamic> json) {
    return AniListTitle(
        english: json['english'] ?? null,
        romaji: json['romaji'] ?? null,
        native: json['native'] ?? null,
        userPreferred: json['userPreferred'] ?? null);
  }
}
