const String GetUserListByStatus = r'''
query getUserListByStatus($username: String!, $type: MediaType!, $status: MediaListStatus!, $page: Int) {
  page: Page(page: $page) {
    pageInfo {
      total
      perPage
      currentPage
      lastPage
      hasNextPage
    }
    mediaList(userName: $username, type: $type, status: $status) {
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
''';
