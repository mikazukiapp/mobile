import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:mikazuki/shared/AniList/query/SearchAnime.gql.dart';
import 'package:mikazuki/shared/AniList/types/SearchResult.dart';

class AniListRepository with ChangeNotifier {
  static AniListRepository _instance;
  GraphQLClient _gqlClient;
  bool _isLoggedIn = false;

  get isLoggedIn {
    return this._isLoggedIn;
  }

  set isLoggedIn(bool value) {
    this._isLoggedIn = value;
    notifyListeners();
  }

  AniListRepository._internal() {
    HttpLink link = HttpLink(uri: 'https://graphql.anilist.co/');
    _gqlClient = GraphQLClient(link: link, cache: InMemoryCache());
  }

  static AniListRepository getInstance() {
    if (_instance == null) {
      _instance = AniListRepository._internal();
    }

    return _instance;
  }

  Future<List<SearchResult>> searchAnime(String query) async {
    final QueryOptions options = QueryOptions(
        documentNode: gql(SearchAnime),
        variables: <String, dynamic>{
          'query': query,
          'type': 'ANIME',
          'onList': false,
          'isAdult': false,
        });

    final QueryResult result = await _gqlClient.query(options);

    if (result.hasException) {
      print(result.exception.toString());
    }

    final List<dynamic> data = result.data['page']['media'] as List<dynamic>;
    final List<SearchResult> results = [];

    data.forEach((element) {
      results.add(SearchResult.fromJson(element));
    });

    return results;
  }
}
