class SearchMovieParameter {
  final String searchValue;
  final String language;
  final String locationLanguage;
  final int page;

  const SearchMovieParameter(
      {required this.language,
      required this.locationLanguage,
      required this.searchValue,
      required this.page});
}
