const String SearchMedia = r'''
query searchMedia($query: String!, $type: MediaType, $genres: [String], $onList: Boolean, $isAdult: Boolean) {
  page: Page {
    media(search: $query, type: $type, genre_in: $genres, onList: $onList, isAdult: $isAdult) {
      id
      title {
        userPreferred
      }
      averageScore
      meanScore
      coverImage {
        extraLarge
      }
      episodes
      chapters
      volumes
      status
      type
      format
      nextAiringEpisode {
        episode
      }
      studios(isMain: true) {
        nodes {
          name
          isAnimationStudio
        }
      }
      isAdult
      mediaListEntry {
        id
        status
        score
        progress
        progressVolumes
      }
    }
  }
}
''';
