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
          episodes
          type
          coverImage {
            color
            medium
            extraLarge
          }
          title {
            romaji
            english
            native
          }
        }
      }
    }
  }
}
''';
