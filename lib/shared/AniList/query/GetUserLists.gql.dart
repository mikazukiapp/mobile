const String GetUserLists = r'''
query getUserLists($userName: String!, $type: MediaType!) {
  collection: MediaListCollection(userName: $userName, type: $type) {
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
          coverImage {
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
