import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';

abstract class TrendingMovieFailures implements Failures {
  @override
  final String failureMessage;

  const TrendingMovieFailures(this.failureMessage);
}
