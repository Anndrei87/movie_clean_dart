import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';

abstract class SearchMovieFailureGeneral implements Failures {
  @override
  final String failureMessage;

  const SearchMovieFailureGeneral(this.failureMessage);
}
