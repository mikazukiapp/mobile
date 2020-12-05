import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:mikazuki/shared/AniList/GraphQLConfiguration.dart';
import 'package:mikazuki/shared/AniList/query/GetUserLists.gql.dart';
import 'package:mikazuki/shared/AniList/query/SearchAnime.gql.dart';
import 'package:mikazuki/shared/AniList/types/MediaType.dart';
import 'package:mikazuki/shared/AniList/types/SearchResult.dart';
import 'package:mikazuki/shared/AniList/types/UserList.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';

class AniListRepository with ChangeNotifier {
  static AniListRepository _instance;
  bool _isLoggedIn = false;

  get isLoggedIn {
    return this._isLoggedIn;
  }

  set isLoggedIn(bool value) {
    this._isLoggedIn = value;
    notifyListeners();
  }

  AniListRepository._internal();

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

    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryResult result = await client.query(options);

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

    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryResult result = await client.query(options);

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
  Future<dynamic> getUserListByStatus(AniListUserListStatus status, {AniListMediaType type = AniListMediaType.Anime}) async {
    Map<String, dynamic> variables = <String, dynamic> {
      // TODO: change username to logged in user's
      'userName': 'NicoAiko',
      'type': getStringifiedAniListMediaType(type),
      'status': [getStringifiedAniListUserListStatus(status)],
    };

    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryOptions options = QueryOptions(documentNode: gql(GetUserLists), variables: variables);
    final QueryResult result = await client.query(options);

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
