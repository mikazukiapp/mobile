import 'package:flutter/material.dart';
import '../../shared/AniList/types/SearchResult.dart';

class SearchResultItem extends StatelessWidget {
  SearchResultItem(this.item);

  final SearchResult item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 4.0, top: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: item.id,
            child: SizedBox(
              width: 64.0,
              height: 96.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  item.coverImage.getSmallest(),
                  fit: BoxFit.fitHeight,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }

                    return Center(
                      child: SizedBox(
                        width: 24.0,
                        height: 24.0,
                        child: CircularProgressIndicator(strokeWidth: 2.0),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 8.0, top: 4.0),
              height: 96.0,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 2, child: Text(item.title.userPreferred, maxLines: 3,)),
                      Container(
                        padding: EdgeInsets.only(left: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              item.averageScore?.toString() ?? '---',
                              style: TextStyle(
                                // color: Colors.grey[700],
                                fontSize: 12.0,
                              ),
                            ),
                            Icon(
                              Icons.star,
                              // color: Colors.grey[700],
                              size: 12.0,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Text(
                    '${item.episodes.toString()} episodes',
                    style: TextStyle(
                      // color: Colors.grey[700],
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    item.statusTitle,
                    style: TextStyle(
                      // color: Colors.grey[700],
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    // return Center(
    //   child: Container(
    //     padding: EdgeInsets.all(16.0),
    //     child: Hero(
    //       tag: item.id,
    //       child: Stack(
    //         children: [
    //           Center(
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(8.0),
                  // child: Image.network(
                  //   item.coverImage.getSmallest(),
                  //   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
                  //     if (loadingProgress == null) {
                  //       return child;
                  //     }

                  //     return Center(
                  //       child: SizedBox(
                  //         width: 24.0,
                  //         height: 24.0,
                  //         child: CircularProgressIndicator(strokeWidth: 2.0),
                  //       ),
                  //     );
                  //   },
                  // ),
    //             ),
    //           ),
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             children: [
    //               Container(
    //                 width: double.infinity,
    //                 color: Color.fromARGB(122, 0, 0, 0),
                    // child: Text(
                    //   item.title.userPreferred,
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 24.0,
                    //     shadows: [Shadow(blurRadius: 4.0, color: Colors.white)],
                    //   ),
                    // ),
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    // return Card(
    //   borderOnForeground: false,
    //   elevation: 0,
    //   child: Row(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       Flexible(
    //         child: Image.network(
    //           item.coverImage.getSmallest(),

            //   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
            //     if (loadingProgress == null) {
            //       return child;
            //     }

            //     return Center(
            //       child: SizedBox(
            //         width: 24.0,
            //         height: 24.0,
            //         child: CircularProgressIndicator(strokeWidth: 2.0),
            //       ),
            //     );
            //   },
            // ),
    //       ),
    //       Expanded(
    //         flex: 2,
    //         child: Container(
    //           padding: EdgeInsets.all(4.0),
    //           child: Text(item.title.userPreferred),
    //         )
    //       ),
    //     ],
    //   ),
    //   // leading: Image.network(
    //   //   item.coverImage.getSmallest(),
    //   //   loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
    //   //     if (loadingProgress == null) {
    //   //       return child;
    //   //     }

    //   //     return Center(
    //   //       child: SizedBox(
    //   //         width: 24.0,
    //   //         height: 24.0,
    //   //         child: CircularProgressIndicator(strokeWidth: 2.0),
    //   //       ),
    //   //     );
    //   //   },
    //   // ),
    //   // title: Text(item.title.userPreferred),
    // );
  }
}
