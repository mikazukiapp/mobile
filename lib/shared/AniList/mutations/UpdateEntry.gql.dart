const String UpdateEntry = r'''
mutation updateEntry($entryId: Int!, $progress: Int, $score: Float, $status: MediaListStatus, $startedAt: FuzzyDateInput, $completedAt: FuzzyDateInput, $progressVolumes: Int) {
  media: SaveMediaListEntry(id: $entryId, progress: $progress, score: $score, status: $status, startedAt: $startedAt, completedAt: $completedAt, progressVolumes: $progressVolumes) {
    id
    progress
    progressVolumes
    score
    status
    startedAt {
      year
      month
      day
    }
    completedAt {
      year
      month
      day
    }
  }
}
''';
