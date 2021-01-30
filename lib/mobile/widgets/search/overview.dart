import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/widgets/search/animeResultItem.dart';
import 'package:mikazuki/mobile/widgets/search/characterResultItem.dart';
import 'package:mikazuki/mobile/widgets/search/mangaResultItem.dart';
import 'package:mikazuki/mobile/widgets/search/staffResultItem.dart';
import 'package:mikazuki/mobile/widgets/util/MikazukiExpansionTile.dart';
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
          MikazukiExpansionTile(
            title: Text('Anime (${anime.length})'),
            initiallyExpanded: true,
            children: anime.map((element) {
              return AnimeSearchResultItemWidget(element);
            }).toList(),
          ),
        if (books.isNotEmpty)
          MikazukiExpansionTile(
            title: Text('Books (${books.length})'),
            initiallyExpanded: true,
            children: books.map((element) {
              return MangaSearchResultItemWidget(element);
            }).toList(),
          ),
        if (miscMedia.isNotEmpty)
          MikazukiExpansionTile(
            title: Text('Miscellaneous (${miscMedia.length})'),
            initiallyExpanded: true,
            children: miscMedia.map((element) {
              return AnimeSearchResultItemWidget(element);
            }).toList(),
          ),
        if (data.characters.isNotEmpty)
          MikazukiExpansionTile(
            title: Text('Characters (${data.characters.length})'),
            initiallyExpanded: true,
            children: data.characters.map((element) {
              return CharacterSearchResultItemWidget(element);
            }).toList(),
          ),
        if (data.staff.isNotEmpty)
          MikazukiExpansionTile(
            title: Text('Staff (${data.staff.length})'),
            initiallyExpanded: true,
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
