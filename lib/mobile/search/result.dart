import 'package:flutter/material.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';
import 'package:mikazuki/shared/AniList/types/SearchResult.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({Key key}) : super();

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResultPage> {
  Future<List<SearchResult>> futureResults;
  List<SearchResult> results;
  TextEditingController _controller;
  bool _loading;
  // String _inputQuery;

  // @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loading = false;
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSearch(String inputQuery) async {
    print(inputQuery);
    if (inputQuery.trim().length == 0) {
      return;
    }

    _loading = true;
    futureResults = AniListRepository.getInstance()
        .searchAnime(inputQuery)
        .whenComplete(() => {_loading = false});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(4.0),
        child: Column(children: <Widget>[
          Flexible(
              child: TextField(
            autocorrect: false,
            controller: _controller,
            onSubmitted: onSearch,
            decoration: InputDecoration(helperText: 'Search...'),
          )),
          Center(
              child: FutureBuilder<List<SearchResult>>(
            future: futureResults,
            builder: (context, snapshot) {
              print(snapshot.hasData);
              print(snapshot.hasError);

              if (snapshot.connectionState == ConnectionState.none) {
                return Container();
              }

              if (snapshot.hasData) {
                return ListView(
                  children: [
                    for (SearchResult result in snapshot.data)
                      ListTile(
                        title: Text(result.title.userPreferred),
                      )
                  ],
                  // children: snapshot.data.map((result) => {
                  //   return ListTile(
                  //     title: result.title,
                  //   );
                  // }),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return CircularProgressIndicator();
            },
          ))
        ]));
  }
}
