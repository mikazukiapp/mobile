const String GetStaffMember = r'''
query getStaffMember($id: Int!, $type: MediaType, $onList: Boolean) {
  staff: Staff(id: $id) {
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
}
''';
