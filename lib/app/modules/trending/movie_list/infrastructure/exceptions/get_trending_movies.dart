import 'package:dart_clean_movies/app/modules/trending/movie_list/infrastructure/exceptions/trending_movies.dart';

class GetTrendingMovieListException implements TrendingMovieExeptions {
  @override
  final String messageException;

  const GetTrendingMovieListException(this.messageException);
}
