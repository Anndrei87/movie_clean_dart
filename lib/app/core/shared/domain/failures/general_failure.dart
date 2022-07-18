import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';

class GeneralFailures implements Failures {
  @override
  final String failureMessage;

  const GeneralFailures(this.failureMessage);
}
