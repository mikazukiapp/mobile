const String SearchStaff = r'''
query searchStaff($query: String!, $onList: Boolean) {
  page: Page {
    staff(search: $query) {
      id
      name {
        full
      }
      image {
        large
        medium
      }
      language
      description
      characterMedia(onList: $onList) {
        edges {
          characterRole
          characters {
            name {
              full
            }
          }
          node {
            title {
              userPreferred
            }
          }
        }
      }
    }
  }
}
''';
