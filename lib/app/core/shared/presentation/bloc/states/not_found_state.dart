import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_states.dart';

class NotFoundState implements GeneralStates {
  final NotFoundFailure messageFailure;

  const NotFoundState(this.messageFailure);
}
