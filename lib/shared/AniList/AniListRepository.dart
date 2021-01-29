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
    AniListUser user = await this._fetchOne(
        GetCurrentUser, null, ['user'], (json) => AniListUser.fromJson(json));
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

    return this._fetchAll<AniListMedia>(SearchMedia, variables,
        ['page', 'media'], (json) => AniListMedia.fromJson(json));
  }

  Future<List<AniListCharacter>> searchCharacters(String query,
      {AniListMediaType type, bool onList}) async {
    Map<String, dynamic> variables =
        ISearchMedia(query: query, type: type, onList: onList).toJson();

    return this._fetchAll<AniListCharacter>(SearchCharacter, variables,
        ['page', 'characters'], (json) => AniListCharacter.fromJson(json));
  }

  Future<List<AniListStaff>> searchStaff(String query, {bool onList}) async {
    Map<String, dynamic> variables =
        ISearchStaff(query: query, onList: onList).toJson();

    return this._fetchAll<AniListStaff>(SearchStaff, variables,
        ['page', 'staff'], (json) => AniListStaff.fromJson(json));
  }

  Future<AniListStaff> getStaffMember(int id,
      {AniListMediaType type, bool onList}) async {
    Map<String, dynamic> variables =
        IGetStaffMember(id: id, type: type, onList: onList).toJson();

    return this._fetchOne<AniListStaff>(GetStaffMember, variables, ['staff'],
        (json) => AniListStaff.fromJson(json));
  }

  Future<List<AniListUserList>> getUserLists(
      {AniListMediaType type = AniListMediaType.Anime}) async {
    Map<String, dynamic> variables =
        IGetUserLists(userName: this.username, type: type).toJson();

    return this._fetchAll<AniListUserList>(GetUserLists, variables,
        ['collection', 'lists'], (json) => AniListUserList.fromJson(json));
  }

  Future<AniListUserList> getUserListByStatus(
      List<AniListUserListStatus> status,
      {AniListMediaType type = AniListMediaType.Anime}) async {
    Map<String, dynamic> variables = IGetUserLists(
      userName: this.username,
      type: type,
      status: status,
    ).toJson();

    return this._fetchOne<AniListUserList>(GetUserLists, variables,
        ['collection', 'lists', 0], (json) => AniListUserList.fromJson(json));
  }

  /// Sends an add entry request to AniList with [mediaId], [status] and if set, [progress] and [score].
  ///
  /// Returns true if successful.
  Future<bool> addEntry(int mediaId, AniListUserListStatus status,
      {int progress, double score}) {
    Map<String, dynamic> variables = IAddEntry(
            mediaId: mediaId, status: status, score: score, progress: progress)
        .toJson();

    return this._commitMutation(AddEntry, variables);
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

    return this._fetchOne<AniListUserListEntry>(UpdateEntry, variables,
        ['media'], (json) => AniListUserListEntry.fromJson(json));
  }

  Future<bool> removeEntry(int entryId) {
    final Map<String, dynamic> variables = {'entryId': entryId};

    return this._commitMutation(RemoveEntry, variables);
  }

  Future<List<T>> _fetchAll<T>(
      String gqlNode,
      Map<String, dynamic> variables,
      List<dynamic> accessProperty,
      T factory(Map<String, dynamic> json)) async {
    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryOptions options =
        QueryOptions(documentNode: gql(gqlNode), variables: variables);
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }

    final List<dynamic> data = _getByPath(result.data, accessProperty);
    final List<T> lists = [];

    data.forEach((element) {
      lists.add(factory(element));
    });

    return lists;
  }

  Future<T> _fetchOne<T>(
      String gqlNode,
      Map<String, dynamic> variables,
      List<dynamic> accessProperty,
      T factory(Map<String, dynamic> json)) async {
    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryOptions options =
        QueryOptions(documentNode: gql(gqlNode), variables: variables);
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return null;
    }

    return factory(_getByPath(result.data, accessProperty));
  }

  Future<bool> _commitMutation(
      String gqlNode, Map<String, dynamic> variables) async {
    final GraphQLConfiguration config = new GraphQLConfiguration();
    final GraphQLClient client = config.clientToQuery();
    final QueryOptions options =
        QueryOptions(documentNode: gql(gqlNode), variables: variables);
    final QueryResult result = await client.query(options);

    if (result.hasException) {
      print(result.exception.toString());
      return false;
    }

    return true;
  }

  dynamic _getByPath(dynamic object, List<dynamic> path) {
    dynamic current = object;

    path.forEach((element) {
      if (element is! String && element is! int) {
        throw new Exception(
            'Path element was expected to be a string or an integer!');
      }

      current = current[element];
    });

    return current;
  }
}
