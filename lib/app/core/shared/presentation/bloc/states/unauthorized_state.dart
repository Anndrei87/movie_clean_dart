import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_states.dart';

class UnauthorizedState implements GeneralStates {
  final UnauthorizedFailure messageFailure;

  const UnauthorizedState(this.messageFailure);
}
