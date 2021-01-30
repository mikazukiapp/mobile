const String SearchCharacter = r'''
query searchCharacter($query: String!, $type: MediaType, $onList: Boolean) {
  page: Page {
    characters(search: $query) {
      id
      name {
        full
      }
      image {
        large
        medium
      }
      media(type: $type, onList: $onList) {
        edges {
          node {
            title {
              userPreferred
            }
          }
          voiceActors {
            id
            name {
              full
            }
            language
          }
        }
      }
    }
  }
}
''';
