import 'package:mikazuki/shared/AniList/types/Character.dart';
import 'package:mikazuki/shared/AniList/types/Media.dart';
import 'package:mikazuki/shared/AniList/types/Staff.dart';

/// This class is an artifically created one that has no connection to AniList.
/// To summarise search results of media, characters and staff, a Summarisation class is necessary.

class AniListSearchResult {
  final List<AniListMedia> media;
  final List<AniListCharacter> characters;
  final List<AniListStaff> staff;

  AniListSearchResult({
    this.media,
    this.characters,
    this.staff,
  });
}
