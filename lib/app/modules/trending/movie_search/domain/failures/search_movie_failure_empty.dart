import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/failures/search_movie_failure_others.dart';

class SearchMovieFailureEmpty implements SearchMovieFailureGeneral {
  @override
  final String failureMessage;

  const SearchMovieFailureEmpty(this.failureMessage);
}
