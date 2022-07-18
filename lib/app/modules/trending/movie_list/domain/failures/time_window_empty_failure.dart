import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/failures/trending_movies_failures.dart';

class TimeWindowEmptyFailure implements TrendingMovieFailures {
  @override
  final String failureMessage;

  const TimeWindowEmptyFailure(this.failureMessage);
}
