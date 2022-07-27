import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_failure_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_states.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/initial_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/loading_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/not_found_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/unauthorized_state.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer_result.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/failures/get_movie_trailer_failures.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/usecase/movie_trailer_usecase.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/presentation/bloc/events/get_movie_trailer_event.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/presentation/bloc/states/get_movie_trailer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GetMovieTrailerBloc extends Bloc<GetMovieTrailerEvents, GeneralStates>
    implements Disposable {
  final GetMovieTrailerByMovieIdAbstraction usecase;

  GetMovieTrailerBloc(this.usecase) : super(const InitialState()) {
    on<GetMovieTrailerEvent>(_mapGetMovieTrailerToState);
  }

  List<MovieTrailerResult> trailers = [];

  @override
  void dispose() => close();

  void _mapGetMovieTrailerToState(
      GetMovieTrailerEvent event, Emitter<GeneralStates> emitter) async {
    emitter(const LoadingState());
    final result = await usecase(event.movieId);
    emitter(result.fold((l) {
      switch (l.runtimeType) {
        case UnauthorizedFailure:
          return UnauthorizedState(l as UnauthorizedFailure);
        case NotFoundFailure:
          return NotFoundState(l as NotFoundFailure);
        case GeneralFailures:
          return GeneralFailureState(l as GeneralFailures);
        default:
          return GetMovieTrailerFailureState(
              l as GetMovieTrailerResultsFailure);
      }
    }, (r) {
      trailers = r.movieTrailerResults.results;
      return GetMovieTrailerSuccessState(r);
    }));
  }
}
