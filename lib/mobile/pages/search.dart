import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/search/appBar.dart';
import 'package:mikazuki/mobile/widgets/search/overview.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';
import 'package:mikazuki/shared/AniList/types/SearchResult.dart';

class SearchScreenWidget extends StatefulWidget {
  @override
  _SearchScreenWidgetState createState() => _SearchScreenWidgetState();
}

class _SearchScreenWidgetState extends State<SearchScreenWidget> {
  Future<AniListSearchResult> searchResult;
  bool _isLoading;

  void onSearchTrigger(String query) {
    if (query.trim().length == 0) {
      return;
    }

    setState(() {
      _isLoading = true;
      searchResult =
          AniListRepository.getInstance().searchAll(query).whenComplete(() {
        setState(() {
          _isLoading = false;
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    final SearchScreenWidgetArguments args =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AniListSearchAppBar(
        isLoading: _isLoading,
        query: args?.query,
        onSearchTrigger: onSearchTrigger,
      ),
      body: AniListSearchOverview(
        searchResult: searchResult,
        isLoading: _isLoading,
      ),
    );
  }
}

class SearchScreenWidgetArguments {
  final String query;

  SearchScreenWidgetArguments(this.query);
}
