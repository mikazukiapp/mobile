const String SearchCharacter = r'''
query searchCharacter($query: String!, $type: MediaType, $onList: Boolean) {
  page: Page {
    characters(search: $query) {
      name {
        full
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
          }
        }
      }
    }
  }
}
''';
