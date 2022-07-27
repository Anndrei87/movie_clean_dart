import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';

abstract class GetMovieTrailerResultsFailures implements Failures {
  @override
  final String failureMessage;

  GetMovieTrailerResultsFailures(this.failureMessage);
}
