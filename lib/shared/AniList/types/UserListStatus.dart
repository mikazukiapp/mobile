enum AniListUserListStatus {
  Completed,
  Planning,
  Dropped,
  Current,
  Paused,
  Repeating,
}

AniListUserListStatus getAniListUserListStatusByJsonValue(String value) {
  switch (value.toUpperCase()) {
    case 'COMPLETED':
      return AniListUserListStatus.Completed;
    case 'PLANNING':
      return AniListUserListStatus.Planning;
    case 'DROPPED':
      return AniListUserListStatus.Dropped;
    case 'CURRENT':
      return AniListUserListStatus.Current;
    case 'PAUSED':
      return AniListUserListStatus.Paused;
    case 'REPEATING':
      return AniListUserListStatus.Repeating;
    default:
      return null;
  }
}
