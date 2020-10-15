import 'package:flutter/material.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';
import 'package:mikazuki/shared/AniList/types/SearchResult.dart';
import 'package:mikazuki/mobile/search/resultItem.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage({Key key}) : super();

  @override
  _SearchResultState createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResultPage> {
  Future<List<SearchResult>> futureResults;
  List<SearchResult> results;
  TextEditingController _controller;
  bool _isLoading;

  // @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _isLoading = false;
  }

  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSearch(String inputQuery) {
    if (inputQuery.trim().length == 0) {
      return;
    }

    setState(() {
      _isLoading = true;
      futureResults = AniListRepository
        .getInstance()
        .searchAnime(inputQuery).whenComplete(() {
          setState(() {
            _isLoading = false;
          });
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          margin: EdgeInsets.only(bottom: 2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
            color: Theme.of(context).primaryColor,
            boxShadow: <BoxShadow>[
              BoxShadow(blurRadius: 2.0, color: Colors.black)
            ]
          ),
          child: TextField(
            autocorrect: false,
            controller: _controller,
            onSubmitted: onSearch,
            // style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              // labelStyle: TextStyle(color: Colors.white),
              // hintStyle: TextStyle(color: Colors.white),
              hintText: 'Title, Genre, Synonyms...',
              labelText: 'Search query',
              prefixIcon: !_isLoading ?
                Icon(Icons.search, color: Colors.white,) :
                SizedBox(
                  height: 24.0,
                  width: 24.0,
                  child: Transform.scale(
                    scale: 0.5,
                    child: CircularProgressIndicator(
                      strokeWidth: 5.0,
                      semanticsLabel: 'Search Loading Indicator',
                    ),
                  ),
                ),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear, color: Colors.white),
                onPressed: () => _controller.clear(),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<SearchResult>>(
            future: futureResults,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  padding: EdgeInsets.all(12.0),
                  children: snapshot.data.map((result) => SearchResultItem(result)).toList(),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return Container();
            },
          ),
        ),
      ],
    );
  }
}
