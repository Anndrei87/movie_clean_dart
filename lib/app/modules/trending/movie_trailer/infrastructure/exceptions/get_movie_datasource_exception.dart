import 'package:dart_clean_movies/app/modules/trending/movie_trailer/infrastructure/exceptions/get_movie_exception.dart';

class GetMovieTrailerDatasourceException implements GetMovieTrailerExcpetions {
  @override
  final String messageException;

  const GetMovieTrailerDatasourceException(this.messageException);
}
