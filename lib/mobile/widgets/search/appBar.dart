import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mikazuki/mobile/constants.dart';

typedef void QueryCallback(String query);

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

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: this.widget.query);

    if (this.widget.query != null && this.widget.query.length > 0) {
      this.widget.onSearchTrigger(this.widget.query);
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
        onSubmitted: this.widget.onSearchTrigger,
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
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
