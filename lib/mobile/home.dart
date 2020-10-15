import 'package:flutter/material.dart';
import 'package:mikazuki/shared/AniList/types/SearchResult.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super();

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  Future<List<SearchResult>> futureResults;

  @override
  void initState() {
    super.initState();

    // futureResults =
    //     AniListRepository.getInstance().searchAnime('Attack on Titan');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('toast'),
      //     child: FutureBuilder<List<SearchResult>>(
      //   future: futureResults,
      //   builder: (context, snapshot) {
      //     if (snapshot.hasData) {
      //       return ListView(
      //         children: [
      //           for (SearchResult result in snapshot.data)
      //             ListTile(
      //               title: Text(result.title.userPreferred),
      //             )
      //         ],
      //         // children: snapshot.data.map((result) => {
      //         //   return ListTile(
      //         //     title: result.title,
      //         //   );
      //         // }),
      //       );
      //     } else if (snapshot.hasError) {
      //       return Text("${snapshot.error}");
      //     }

      //     return CircularProgressIndicator();
      //   },
      // )),
    );
  }
}
