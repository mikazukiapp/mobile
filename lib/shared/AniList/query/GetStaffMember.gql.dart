const String GetStaffMember = r'''
query getStaffMember($id: Number!, $type: MediaType, $onList: Boolean) {
  name {
    full
  }
  characters {
    edges {
      node {
        name {
          full
        }
        media(type: $type, onList: $onList) {
          nodes {
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
