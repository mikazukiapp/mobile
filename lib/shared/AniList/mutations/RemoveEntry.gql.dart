const String RemoveEntry = r'''
mutation removeEntry($id: Int!) {
  DeleteMediaListEntry(id: $id) {
    deleted
  }
}
''';
