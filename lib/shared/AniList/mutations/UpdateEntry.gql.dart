const String UpdateEntry = r'''
mutation updateEntry($id: Int!, $progress: Int, $score: Int, $status: MediaListStatus, $startedAt: FuzzyDateInput, $completedAt: FuzzyDateInput) {
  media: SaveMediaListEntry(id: $id, progress: $progress, score: $score, status: $status, startedAt: $startedAt, completedAt: $completedAt) {
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
