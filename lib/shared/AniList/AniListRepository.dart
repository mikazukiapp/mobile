import 'dart:async';
import 'package:flutter/material.dart';
import 'package:graphql/client.dart';
import 'package:hive/hive.dart';
import 'package:mikazuki/shared/AniList/GraphQLConfiguration.dart';
import 'package:mikazuki/shared/AniList/mutations/AddEntry.gql.dart';
import 'package:mikazuki/shared/AniList/mutations/AddEntry.interface.dart';
import 'package:mikazuki/shared/AniList/mutations/RemoveEntry.gql.dart';
import 'package:mikazuki/shared/AniList/mutations/UpdateEntry.gql.dart';
import 'package:mikazuki/shared/AniList/mutations/UpdateEntry.interface.dart';
import 'package:mikazuki/shared/AniList/query/GetCurrentUser.gql.dart';
import 'package:mikazuki/shared/AniList/query/GetStaffMember.gql.dart';
import 'package:mikazuki/shared/AniList/query/GetUserLists.gql.dart';
import 'package:mikazuki/shared/AniList/query/SearchCharacter.gql.dart';
import 'package:mikazuki/shared/AniList/query/SearchMedia.gql.dart';
import 'package:mikazuki/shared/AniList/query/SearchStaff.gql.dart';
import 'package:mikazuki/shared/AniList/query/interfaces/GetStaffMember.interface.dart';
import 'package:mikazuki/shared/AniList/query/interfaces/GetUserLists.interface.dart';
import 'package:mikazuki/shared/AniList/query/interfaces/SearchMedia.interface.dart';
import 'package:mikazuki/shared/AniList/query/interfaces/SearchStaff.interface.dart';
import 'package:mikazuki/shared/AniList/types/Character.dart';
import 'package:mikazuki/shared/AniList/types/DateInput.dart';
import 'package:mikazuki/shared/AniList/types/Media.dart';
import 'package:mikazuki/shared/AniList/types/MediaType.dart';
import 'package:mikazuki/shared/AniList/types/SearchResult.dart';
import 'package:mikazuki/shared/AniList/types/Staff.dart';
import 'package:mikazuki/shared/AniList/types/User.dart';
import 'package:mikazuki/shared/AniList/types/UserList.dart';
import 'package:mikazuki/shared/AniList/types/UserListEntry.dart';
import 'package:mikazuki/shared/AniList/types/UserListStatus.dart';
import 'package:mikazuki/shared/Storage/actions.dart';

class AniListRepository with ChangeNotifier {
  static AniListRepository _instance;
  bool _isLoggedIn = false;
  String _username;

  get isLoggedIn {
    return this._isLoggedIn;
  }

  set isLoggedIn(bool value) {
    this._isLoggedIn = value;

    if (!value) {
      this.username = null;
    }

    notifyListeners();
  }

  String get username {
    return this._username;
  }

  set username(String value) {
    this._username = value;
    notifyListeners();
  }

  AniListRepository._internal();

  static AniListRepository getInstance() {
    if (_instance == null) {
      _instance = AniListRepository._internal();
    }

    return _instance;
  }

  Future<AniListUser> getUserData() async {
    final QueryOptions options = QueryOptions(
      documentNode: gql(GetCurrentUser),
    );

    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }

    AniListUser user = AniListUser.fromJson(result.data['user']);

    Box<dynamic> box = Hive.box('anilist_userdata');
    await box.clear();
    await box.put('avatars', user.avatar);
    await box.put('bannerImage', user.bannerImage);
    await box.put('username', user.name);

    return user;
  }

  Future<void> logout() async {
    await Hive.box('anilist_userdata').clear();
    GraphQLConfiguration.removeToken();
    SecureStorageActions.delete('anilist_token');
    isLoggedIn = false;
  }

  Future<AniListSearchResult> searchAll(String query,
      {AniListMediaType type,
      List<String> genres,
      bool onList,
      bool isAdult}) async {
    final List<AniListMedia> media = await this.searchMedia(query,
        type: type, genres: genres, onList: onList, isAdult: isAdult);
    final List<AniListCharacter> characters =
        await this.searchCharacters(query, type: type, onList: onList);
    final List<AniListStaff> staff =
        await this.searchStaff(query, onList: onList);

    return AniListSearchResult(
        characters: characters, media: media, staff: staff);
  }

  Future<List<AniListMedia>> searchMedia(String query,
      {AniListMediaType type,
      List<String> genres,
      bool onList,
      bool isAdult}) async {
    Map<String, dynamic> variables = ISearchMedia(
            query: query,
            type: type,
            genres: genres,
            onList: onList,
            isAdult: isAdult)
        .toJson();
    final QueryOptions options = QueryOptions(
      documentNode: gql(SearchMedia),
      variables: variables,
    );

    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }

    final List<dynamic> data = result.data['page']['media'] as List<dynamic>;
    final List<AniListMedia> results = [];

    data.forEach((element) {
      results.add(AniListMedia.fromJson(element));
    });

    return results;
  }

  Future<List<AniListCharacter>> searchCharacters(String query,
      {AniListMediaType type, bool onList}) async {
    Map<String, dynamic> variables =
        ISearchMedia(query: query, type: type, onList: onList).toJson();
    final QueryOptions options = QueryOptions(
      documentNode: gql(SearchCharacter),
      variables: variables,
    );

    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }

    final List<dynamic> data =
        result.data['page']['characters'] as List<dynamic>;
    final List<AniListCharacter> results = [];

    data.forEach((element) {
      results.add(AniListCharacter.fromJson(element));
    });

    return results;
  }

  Future<List<AniListStaff>> searchStaff(String query, {bool onList}) async {
    Map<String, dynamic> variables =
        ISearchStaff(query: query, onList: onList).toJson();
    final QueryOptions options = QueryOptions(
      documentNode: gql(SearchStaff),
      variables: variables,
    );

    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }

    final List<dynamic> data = result.data['page']['staff'] as List<dynamic>;
    final List<AniListStaff> results = [];

    data.forEach((element) {
      results.add(AniListStaff.fromJson(element));
    });

    return results;
  }

  Future<AniListStaff> getStaffMember(int id,
      {AniListMediaType type, bool onList}) async {
    Map<String, dynamic> variables =
        IGetStaffMember(id: id, type: type, onList: onList).toJson();
    final QueryOptions options = QueryOptions(
      documentNode: gql(GetStaffMember),
      variables: variables,
    );

    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }

    return AniListStaff.fromJson(result.data['staff']);
  }

  Future<List<AniListUserList>> getUserLists(
      {AniListMediaType type = AniListMediaType.Anime}) async {
    final QueryOptions options = QueryOptions(
      documentNode: gql(GetUserLists),
      variables: IGetUserLists(userName: this.username, type: type).toJson(),
    );

    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }

    final List<dynamic> data = result.data['collection']['lists'];
    final List<AniListUserList> lists = [];

    data.forEach((element) {
      lists.add(AniListUserList.fromJson(element));
    });

    return lists;
  }

  Future<AniListUserList> getUserListByStatus(
      List<AniListUserListStatus> status,
      {AniListMediaType type = AniListMediaType.Anime}) async {
    Map<String, dynamic> variables = IGetUserLists(
      userName: this.username,
      type: type,
      status: status,
    ).toJson();

    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryOptions options =
        QueryOptions(documentNode: gql(GetUserLists), variables: variables);
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }

    final Map<String, dynamic> data = result.data['collection']['lists'][0];

    return AniListUserList.fromJson(data);
  }

  /// Sends an add entry request to AniList with [mediaId], [status] and if set, [progress] and [score].
  ///
  /// Returns true if successful.
  Future<bool> addEntry(int mediaId, AniListUserListStatus status,
      {int progress, double score}) async {
    Map<String, dynamic> variables = IAddEntry(
            mediaId: mediaId, status: status, score: score, progress: progress)
        .toJson();

    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryOptions options =
        QueryOptions(documentNode: gql(AddEntry), variables: variables);
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return false;
    }

    return true;
  }

  Future<AniListUserListEntry> updateEntry(int entryId,
      {int progress,
      int progressVolumes,
      double score,
      AniListUserListStatus status,
      AniListDateInput startedAt,
      AniListDateInput completedAt}) async {
    Map<String, dynamic> variables = IUpdateEntry(
            entryId: entryId,
            progress: progress,
            progressVolumes: progressVolumes,
            score: score,
            status: status,
            startedAt: startedAt,
            completedAt: completedAt)
        .toJson();

    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryOptions options =
        QueryOptions(documentNode: gql(UpdateEntry), variables: variables);
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }

    return AniListUserListEntry.fromJson(result.data['media']);
  }

  Future<bool> removeEntry(int entryId) async {
    final Map<String, dynamic> variables = {'entryId': entryId};
    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryOptions options =
        QueryOptions(documentNode: gql(RemoveEntry), variables: variables);
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return false;
    }

    return true;
  }
}
