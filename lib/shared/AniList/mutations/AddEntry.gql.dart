const String AddEntry = r'''
mutation addEntry($mediaId: Int!, $status: MediaListStatus!, $progress: Int, $score: Float) {
  media: SaveMediaListEntry(mediaId: $mediaId, status: $status, progress: $progress, score: $score) {
    id
  }
}
''';
