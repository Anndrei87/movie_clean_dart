import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';

class UnauthorizedFailure implements Failures {
  @override
  final String failureMessage;

  const UnauthorizedFailure(this.failureMessage);
}
