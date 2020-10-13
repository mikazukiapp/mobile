import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/navigation/bottomBar.dart';
import 'package:mikazuki/shared/AniList/AniListRepository.dart';
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

    futureResults =
        AniListRepository.getInstance().searchAnime('Attack on Titan');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          padding: EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/AppIcon.png',
          ),
        ),
        title: Text('NicoAiko'),
      ),
      // body: Center(
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
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
