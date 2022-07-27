import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/failures/get_movie_trailer_failure.dart';

class GetMovieTrailerResultsFailure implements GetMovieTrailerResultsFailures {
  @override
  final String failureMessage;

  const GetMovieTrailerResultsFailure(this.failureMessage);
}
