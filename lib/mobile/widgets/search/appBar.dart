import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mikazuki/mobile/constants.dart';
import 'package:mikazuki/mobile/widgets/search/SearchFilter.dart';

typedef void QueryCallback(String query, List<SearchFilter> _filterSettings);

class AniListSearchAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  final QueryCallback onSearchTrigger;
  final bool isLoading;
  final String query;

  AniListSearchAppBar(
      {@required this.onSearchTrigger,
      @required this.isLoading,
      this.query,
      Key key})
      : super(key: key);

  @override
  _AniListSearchAppBarState createState() => _AniListSearchAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _AniListSearchAppBarState extends State<AniListSearchAppBar> {
  TextEditingController _textController;
  List<SearchFilter> _checkedFormats;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: this.widget.query);
    _checkedFormats = [];

    if (this.widget.query != null && this.widget.query.length > 0) {
      this.widget.onSearchTrigger(this.widget.query, _checkedFormats);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(kMikazukiSvgLogo),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: TextField(
        autocorrect: true,
        controller: _textController,
        onSubmitted: (String query) =>
            this.widget.onSearchTrigger(query, _checkedFormats),
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Title, Character, Staff member...',
          labelText: 'Search query...',
          hintStyle: Theme.of(context).primaryTextTheme.subtitle1,
          labelStyle: Theme.of(context).primaryTextTheme.subtitle1,
          border: InputBorder.none,
        ),
      ),
      actions: [
        if (!this.widget.isLoading)
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              _textController.clear();
            },
          ),
        if (this.widget.isLoading)
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: SizedBox(
                height: 24.0,
                width: 24.0,
                child: CircularProgressIndicator(
                  strokeWidth: 2.0,
                  semanticsLabel: 'Search loading indicator',
                  valueColor: new AlwaysStoppedAnimation(
                    Theme.of(context).primaryIconTheme.color,
                  ),
                ),
              ),
            ),
          ),
        PopupMenuButton<SearchFilter>(
          tooltip: 'Search filters',
          padding: EdgeInsets.zero,
          icon: Icon(Icons.sort),
          offset: Offset(0, 56.0),
          onSelected: (SearchFilter result) {
            if (_checkedFormats.contains(result)) {
              _checkedFormats.remove(result);
              return;
            } else {
              _checkedFormats.add(result);
              return;
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<SearchFilter>>[
            PopupMenuItem(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Search filters',
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    'Enabling any of these filters means exclusively searching for the checked types',
                    style: TextStyle(fontSize: 12),
                  )
                ],
              ),
            ),
            CheckedPopupMenuItem<SearchFilter>(
              checked: _checkedFormats.contains(SearchFilter.Anime),
              value: SearchFilter.Anime,
              child: Text('Anime'),
            ),
            CheckedPopupMenuItem<SearchFilter>(
              checked: _checkedFormats.contains(SearchFilter.Books),
              value: SearchFilter.Books,
              child: Text('Books'),
            ),
            CheckedPopupMenuItem<SearchFilter>(
              checked: _checkedFormats.contains(SearchFilter.Characters),
              value: SearchFilter.Characters,
              child: Text('Characters'),
            ),
            CheckedPopupMenuItem<SearchFilter>(
              checked: _checkedFormats.contains(SearchFilter.Staff),
              value: SearchFilter.Staff,
              child: Text('Staff'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
