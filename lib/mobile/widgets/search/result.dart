import 'package:flutter/material.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';
import 'package:mikazuki/mobile/widgets/search/resultItem.dart';

class SearchResultWidget extends StatefulWidget {
  SearchResultWidget({Key key}) : super();

  @override
  _SearchResultWidgetState createState() => _SearchResultWidgetState();
}

class _SearchResultWidgetState extends State<SearchResultWidget> {
  Future<List<dynamic>> futureResults;
  List<dynamic> results;
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
      futureResults = AniListRepository.getInstance()
          .searchMedia(inputQuery)
          .whenComplete(() {
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
          // padding: EdgeInsets.only(left: 4.0, right: 4.0),
          margin: EdgeInsets.only(bottom: 2.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(blurRadius: 2.0, color: Colors.black)
            ],
          ),
          child: TextField(
            autocorrect: false,
            controller: _controller,
            onSubmitted: onSearch,
            style: Theme.of(context).primaryTextTheme.subtitle1,
            decoration: InputDecoration(
              hintStyle: Theme.of(context).primaryTextTheme.subtitle1,
              labelStyle: Theme.of(context).primaryTextTheme.subtitle1,
              hintText: 'Title, Genre, Synonyms...',
              labelText: 'Search query',
              prefixIcon: !_isLoading
                  ? Icon(Icons.search,
                      color: Theme.of(context).primaryIconTheme.color)
                  : SizedBox(
                      height: 24.0,
                      width: 24.0,
                      child: Transform.scale(
                        scale: 0.5,
                        child: CircularProgressIndicator(
                          strokeWidth: 5.0,
                          semanticsLabel: 'Search Loading Indicator',
                          valueColor: new AlwaysStoppedAnimation(
                              Theme.of(context).primaryIconTheme.color),
                        ),
                      ),
                    ),
              suffixIcon: IconButton(
                icon: Icon(Icons.clear,
                    color: Theme.of(context).primaryIconTheme.color),
                onPressed: () => _controller.clear(),
              ),
              border: InputBorder.none,
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: futureResults,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  padding: EdgeInsets.all(12.0),
                  children: snapshot.data
                      .map((result) => SearchResultItem(result))
                      .toList(),
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
