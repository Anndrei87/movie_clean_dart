import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';

class NotFoundFailure implements Failures {
  @override
  final String failureMessage;

  const NotFoundFailure(this.failureMessage);
}
