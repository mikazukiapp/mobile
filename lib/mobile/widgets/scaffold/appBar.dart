import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mikazuki/mobile/constants.dart';
import 'package:mikazuki/mobile/pages/search.dart';

class MikazukiAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  MikazukiAppBar({this.title});

  @override
  State<StatefulWidget> createState() => MikazukiAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class MikazukiAppBarState extends State<MikazukiAppBar>
    with SingleTickerProviderStateMixin {
  TextEditingController _textController;
  AnimationController _animationController;
  Animation<Offset> _offsetAnimation;
  bool _isQuickSearchActive;

  Widget _buildQuickSearchField(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          _animationController.forward().then((_) {
            setState(() {
              _isQuickSearchActive = !_isQuickSearchActive;
            });

            _animationController.reverse();
          });
        },
      ),
      title: TextField(
        autocorrect: true,
        controller: _textController,
        onSubmitted: _onQuickSearchSubmit,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Title, Genre, Synonyms...',
          labelText: 'Search query...',
          hintStyle: Theme.of(context).primaryTextTheme.subtitle1,
          labelStyle: Theme.of(context).primaryTextTheme.subtitle1,
          border: InputBorder.none,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            _textController.clear();
          },
        ),
      ],
    );
  }

  void _onQuickSearchSubmit(String query) {
    if (query.trim().length == 0) {
      return;
    }

    print(query);

    Navigator.pushNamed(context, '/search',
        arguments: SearchScreenWidgetArguments(query));
  }

  @override
  void initState() {
    super.initState();

    _textController = TextEditingController();
    _isQuickSearchActive = false;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0),
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _animationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = _isQuickSearchActive
        ? _buildQuickSearchField(context)
        : _buildAppBar(context);

    return SlideTransition(
      position: _offsetAnimation,
      child: child,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(kMikazukiSvgLogo),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: widget.title != null ? Text(widget.title) : null,
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.search),
          tooltip: 'Search',
          onPressed: () {
            _animationController.forward().then((_) {
              setState(() {
                _isQuickSearchActive = !_isQuickSearchActive;
              });

              _animationController.reverse();
            });
          },
        ),
        PopupMenuButton(
          tooltip: 'Filtering and Sorting',
          padding: EdgeInsets.zero,
          icon: Icon(Icons.sort),
          offset: Offset(0, 56.0),
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              enabled: false,
              child: Text('Sorting (to be implemented...)'),
            ),
            const PopupMenuItem(
              enabled: false,
              child: ListTile(
                dense: true,
                leading: Icon(Icons.title),
                title: Text('Sort by title'),
              ),
            ),
            const PopupMenuItem(
              enabled: false,
              child: ListTile(
                dense: true,
                leading: Icon(Icons.tv),
                title: Text('Sort by episode amount'),
              ),
            ),
          ],
        ),
        //   IconButton(
        //       icon: appTheme.currentTheme() == ThemeMode.light
        //           ? Icon(Icons.lightbulb, color: Colors.yellow)
        //           : Icon(Icons.lightbulb_outline, color: Colors.white),
        //       onPressed: () {
        //         setState(() {
        //           appTheme.switchTheme();
        //         });
        //       })
      ],
    );
  }
}
