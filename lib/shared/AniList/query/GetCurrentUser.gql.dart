const String GetCurrentUser = r'''
query {
  user: Viewer {
    id
    name
    avatar {
      large
      medium
    }
    bannerImage
  }
}
''';
