import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:mikazuki/shared/AniList/query/GetUserLists.gql.dart';
import 'package:mikazuki/shared/AniList/query/SearchAnime.gql.dart';
import 'package:mikazuki/shared/AniList/types/SearchResult.dart';
import 'package:mikazuki/shared/AniList/types/UserList.dart';

class AniListRepository with ChangeNotifier {
  final HttpLink _httpLink = HttpLink(uri: 'https://graphql.anilist.co/');
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

  void setToken(String token) {
    AuthLink _authLink = AuthLink(getToken: () async => 'Bearer $token');

    _gqlClient = GraphQLClient(link: _authLink.concat(_httpLink), cache: InMemoryCache());
  }

  void removeToken() {
    _gqlClient = GraphQLClient(link: _httpLink, cache: InMemoryCache());
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

  Future<dynamic> getUserAnimeLists() async {
    final QueryOptions options = QueryOptions(
      documentNode: gql(GetUserLists),
      variables: <String, dynamic> {
        // TODO: Change userName to logged in user's
        'userName': 'NicoAiko',
        'type': 'ANIME',
      },
    );

    final QueryResult result = await _gqlClient.query(options);

    if (result.hasException) {
      print(result.exception.toString());
    }

    final List<dynamic> data = result.data['collection']['lists'];
    final List<AniListUserList> lists = [];

    data.forEach((element) {
      lists.add(AniListUserList.fromJson(element));
    });

    print(lists);
  }
}
