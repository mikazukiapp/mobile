import 'package:flutter/material.dart';
import 'package:mikazuki/mobile/mobileScaffold.dart';
import 'package:mikazuki/mobile/widgets/search/result.dart';

class SearchScreenWidget extends StatefulWidget {
  @override
  _SearchScreenWidgetState createState() => _SearchScreenWidgetState();
}

class _SearchScreenWidgetState extends State<SearchScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return MikazukiScaffold(
      body: SearchResultWidget(),
    );
  }
}
