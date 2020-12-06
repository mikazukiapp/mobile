const String AddEntry = r'''
mutation addEntry($mediaId: Int!, $status: MediaListStatus!, $progress: Int, $score: Float, $progressVolumes: Int) {
  media: SaveMediaListEntry(mediaId: $mediaId, status: $status, progress: $progress, score: $score, progressVolumes: $progressVolumes) {
    id
  }
}
''';
