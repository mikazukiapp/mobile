enum MediaStatus {
  Cancelled,
  Finished,
  NotYetReleased,
  Releasing,
}

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

class CoverImage {
  final String color;
  final String medium;
  final String large;
  final String extraLarge;

  CoverImage({this.color, this.medium, this.large, this.extraLarge});

  String getSmallest() {
    return medium ?? large ?? extraLarge ?? null;
  }

  factory CoverImage.fromJson(Map<String, dynamic> json) {
    return CoverImage(
        color: json['color'] ?? null,
        medium: json['medium'] ?? null,
        large: json['large'] ?? null,
        extraLarge: json['extraLarge'] ?? null);
  }
}

class NextAiringEpisode {
  final int id;
  final int airingAt;
  final int timeUntilAiring;
  final int episode;
  final int mediaId;

  NextAiringEpisode(
      {this.id,
      this.airingAt,
      this.timeUntilAiring,
      this.episode,
      this.mediaId});

  factory NextAiringEpisode.fromJson(Map<String, dynamic> json) {
    return NextAiringEpisode(
      id: json['id'] ?? null,
      airingAt: json['airingAt'] ?? null,
      timeUntilAiring: json['timeUntilAiring'] ?? null,
      episode: json['episode'] ?? null,
      mediaId: json['mediaId'] ?? null,
    );
  }
}

class Studio {
  final List<StudioNode> nodes;

  Studio({this.nodes});

  factory Studio.fromJson(Map<String, dynamic> json) {
    final List<StudioNode> nodes = [];
    ((json['nodes'] ?? []) as List<dynamic>).forEach((element) {
      nodes.add(StudioNode.fromJson(element));
    });

    return Studio(nodes: nodes);
  }
}

class StudioNode {
  final int id;
  final String name;
  final bool isAnimationStudio;
  final String siteUrl;

  StudioNode({this.id, this.name, this.isAnimationStudio, this.siteUrl});

  factory StudioNode.fromJson(Map<String, dynamic> json) {
    return StudioNode(
      id: json['id'] ?? null,
      name: json['name'] ?? null,
      isAnimationStudio: json['isAnimationStudio'] ?? null,
      siteUrl: json['siteUrl'] ?? null,
    );
  }
}

class SearchResult {
  final int id;
  final AniListTitle title;
  final int averageScore;
  final CoverImage coverImage;
  final int episodes;
  final NextAiringEpisode nextAiringEpisode;
  final Studio studios;
  final bool isAdult;
  final MediaStatus status;

  SearchResult({
    this.id,
    this.title,
    this.averageScore,
    this.coverImage,
    this.episodes,
    this.nextAiringEpisode,
    this.studios,
    this.isAdult,
    this.status,
  });

  String get statusTitle {
    switch (this.status) {
      case MediaStatus.Cancelled:
        return 'Cancelled';
      case MediaStatus.Finished:
        return 'Finished';
      case MediaStatus.NotYetReleased:
        return 'Not yet released';
      case MediaStatus.Releasing:
        return 'Releasing';
      default:
        return 'Status unknown';
    }
  }

  static MediaStatus getStatusByString(String status) {
    switch (status.toUpperCase()) {
      case 'CANCELLED':
        return MediaStatus.Cancelled;
      case 'FINISHED':
        return MediaStatus.Finished;
      case 'NOT_YET_RELEASED':
        return MediaStatus.NotYetReleased;
      case 'RELEASING':
        return MediaStatus.Releasing;
      default:
        return null;
    }
  }

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      id: json['id'] ?? null,
      title: AniListTitle.fromJson(json['title'] ?? {}),
      averageScore: json['averageScore'] ?? null,
      coverImage: CoverImage.fromJson(json['coverImage'] ?? {}),
      episodes: json['episodes'] ?? null,
      nextAiringEpisode:
          NextAiringEpisode.fromJson(json['nextAiringEpisode'] ?? {}),
      studios: Studio.fromJson(json['studios'] ?? {}),
      isAdult: json['isAdult'] ?? null,
      status: SearchResult.getStatusByString(json['status']),
    );
  }
}
