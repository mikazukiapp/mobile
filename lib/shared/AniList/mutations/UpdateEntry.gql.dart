const String UpdateEntry = r'''
mutation updateEntry($entryId: Int!, $progress: Int, $score: Float, $status: MediaListStatus, $startedAt: FuzzyDateInput, $completedAt: FuzzyDateInput) {
  media: SaveMediaListEntry(id: $entryId, progress: $progress, score: $score, status: $status, startedAt: $startedAt, completedAt: $completedAt) {
    id
    progress
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
