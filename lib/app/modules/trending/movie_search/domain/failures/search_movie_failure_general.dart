import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/failures/search_movie_failure_others.dart';

class SearchMovieFailure implements SearchMovieFailureGeneral {
  @override
  final String failureMessage;

  const SearchMovieFailure(this.failureMessage);
}
