import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_states.dart';

class GeneralFailureState implements GeneralStates {
  final GeneralFailures messageFailure;

  const GeneralFailureState(this.messageFailure);
}
