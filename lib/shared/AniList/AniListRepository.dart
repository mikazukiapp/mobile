import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mikazuki/shared/AniList/query/GetUserListByStatus.gql.dart';
import 'package:mikazuki/shared/AniList/query/GetUserLists.gql.dart';
import 'package:mikazuki/shared/AniList/query/SearchAnime.gql.dart';
import 'package:mikazuki/shared/AniList/types/MediaType.dart';
import 'package:mikazuki/shared/AniList/types/PageInfo.dart';
import 'package:mikazuki/shared/AniList/types/SearchResult.dart';
import 'package:mikazuki/shared/AniList/types/UserList.dart';
import 'package:mikazuki/shared/AniList/types/UserListEntry.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

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

  // TODO: Set proper Future typing
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

  // TODO: Set proper Future typing
  Future<dynamic> getUserListByStatus(AniListUserListStatus status, {@JsonKey(unknownEnumValue: AniListMediaType.Anime) AniListMediaType type = AniListMediaType.Anime}) async {
    Map<String, dynamic> variables = <String, dynamic> {
      // TODO: change username to logged in user's
      'username': 'NicoAiko',
      'type': json.encode(type),
      'status': status,
    };

    final QueryOptions options = QueryOptions(documentNode: gql(GetUserListByStatus));

    final List<AniListUserListEntry> userListEntries = [];
    QueryResult result;
    PageInfo pageInfo;
    dynamic page;
    int pageNumber = 0;

    do {
      variables['page'] = ++pageNumber;
      options.variables = variables;

      result = await _gqlClient.query(options);
      page = result.data['page'];
      pageInfo = PageInfo.fromJson(page['pageInfo']);

      if (result.hasException) {
        print(result.exception.toString());
      }

      (page['mediaList'] as List<dynamic>).forEach((element) {
        userListEntries.add(AniListUserListEntry.fromJson(element));
      });
    } while (pageInfo.hasNextPage);

    AniListUserList list = AniListUserList(entries: userListEntries, status: status);

    print(list);
  }
}
