import 'package:dart_clean_movies/app/modules/trending/movie_search/infrastructure/exceptions/search_movie_exception.dart';

class SearchMovieDataSourceException implements SearchMovieException {
  @override
  final String messageException;

  const SearchMovieDataSourceException(this.messageException);
}
