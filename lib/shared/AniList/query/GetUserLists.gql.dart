const String GetUserLists = r'''
query getUserLists($userName: String!, $type: MediaType!, $status: [MediaListStatus]) {
  collection: MediaListCollection(userName: $userName, type: $type, status_in: $status) {
    lists {
      name
      status
      entries {
        id
        progress
        status
        score
        updatedAt
        media {
          id
          description(asHtml: false)
          episodes
          format
          isAdult
          isLicensed
          season
          status
          type
          coverImage {
            color
            medium
            extraLarge
          }
          nextAiringEpisode {
            airingAt
            timeUntilAiring
            episode
          }
          title {
            romaji
            english
            native
            userPreferred
          }
        }
      }
    }
  }
}
''';
