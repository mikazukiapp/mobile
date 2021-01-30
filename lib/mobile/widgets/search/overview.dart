import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/search/animeResultItem.dart';
import 'package:mikazuki/mobile/widgets/search/characterResultItem.dart';
import 'package:mikazuki/mobile/widgets/search/mangaResultItem.dart';
import 'package:mikazuki/mobile/widgets/search/staffResultItem.dart';
import 'package:mikazuki/shared/AniList/types/Media.dart';
import 'package:mikazuki/shared/AniList/types/SearchResult.dart';

class AniListSearchOverview extends StatefulWidget {
  final Future<AniListSearchResult> searchResult;
  final bool isLoading;

  AniListSearchOverview({this.searchResult, this.isLoading, Key key})
      : super(key: key);

  @override
  _AniListSearchOverviewState createState() => _AniListSearchOverviewState();
}

class _AniListSearchOverviewState extends State<AniListSearchOverview> {
  Widget resultListView(BuildContext context, AniListSearchResult data) {
    List<AniListMedia> anime = data.media
        .where((element) => AniListMedia.isAnime(element.format))
        .toList();
    List<AniListMedia> books = data.media
        .where((element) => AniListMedia.isBook(element.format))
        .toList();
    List<AniListMedia> miscMedia = data.media
        .where((element) => AniListMedia.isMisc(element.format))
        .toList();

    return ListView(
      padding: EdgeInsets.all(8.0),
      children: [
        if (anime.isNotEmpty)
          ExpansionTile(
            title: Text('Anime (${anime.length})'),
            initiallyExpanded: true,
            children: anime.map((element) {
              return AnimeSearchResultItemWidget(element);
            }).toList(),
          ),
        if (books.isNotEmpty)
          ExpansionTile(
            title: Text('Books (${books.length})'),
            initiallyExpanded: anime.length == 0,
            children: books.map((element) {
              return MangaSearchResultItemWidget(element);
            }).toList(),
          ),
        if (miscMedia.isNotEmpty)
          ExpansionTile(
            title: Text('Miscellaneous (${miscMedia.length})'),
            initiallyExpanded: anime.length == 0 && books.length == 0,
            children: miscMedia.map((element) {
              return AnimeSearchResultItemWidget(element);
            }).toList(),
          ),
        if (data.characters.isNotEmpty)
          ExpansionTile(
            title: Text('Characters (${data.characters.length})'),
            initiallyExpanded:
                anime.isEmpty && books.isEmpty && miscMedia.isEmpty,
            children: data.characters.map((element) {
              return CharacterSearchResultItemWidget(element);
            }).toList(),
          ),
        if (data.staff.isNotEmpty)
          ExpansionTile(
            title: Text('Staff (${data.staff.length})'),
            initiallyExpanded: anime.isEmpty &&
                books.isEmpty &&
                miscMedia.isEmpty &&
                data.characters.isEmpty,
            children: data.staff.map((element) {
              return StaffSearchResultItemWidget(element);
            }).toList(),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (this.widget.searchResult == null) {
      return Container();
    }

    return FutureBuilder<AniListSearchResult>(
      future: this.widget.searchResult,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return resultListView(context, snapshot.data);
        } else if (snapshot.hasError) {
          return Text(snapshot.error);
        }

        return Container();
      },
    );
  }
}
