class AppRoutePath {
  final int id;
  final String location;
  final bool isUnknown;

  AppRoutePath.home()
      : id = null,
        location = '/',
        isUnknown = false;

  AppRoutePath.search()
      : id = null,
        location = '/search',
        isUnknown = false;

  AppRoutePath.unknown()
      : id = null,
        location = '',
        isUnknown = true;

  bool get isHomePage => location == '/';

  bool get isSearchPage => location == '/search';
}
