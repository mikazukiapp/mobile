const String RemoveEntry = r'''
mutation removeEntry($entryId: Int!) {
  DeleteMediaListEntry(id: $entryId) {
    deleted
  }
}
''';
