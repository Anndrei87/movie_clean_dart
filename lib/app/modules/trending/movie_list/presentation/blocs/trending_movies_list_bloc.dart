import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_failure_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_states.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/loading_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/not_found_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/unauthorized_state.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/failures/time_window_empty_failure.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/failures/trending_movies_failures.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/usecases/get_movies_by_time_window.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/events/fetch_movies_list_event.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/events/get_movies_list_event.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/events/trending_movies_event.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/states/trending_movies_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GetTrendingMoviesBloc extends Bloc<TrendingMoviesListEvent, GeneralStates>
    implements Disposable {
  final GetTrendingByTimeWindowAbstraction usecase;

  List<Movie> movies = [];
  bool lastPage = false;
  int page = 1;

  GetTrendingMoviesBloc(this.usecase) : super(const LoadingState()) {
    on<GetMoviesListEvent>(_mapGetTrendingMoviesListToState);
    on<FetchTrendingMoviesListEvent>(_mapFetchTrendingMoviesListToState);
  }

  @override
  void dispose() => close();

  void _mapGetTrendingMoviesListToState(
    GetMoviesListEvent event,
    Emitter<GeneralStates> emitter,
  ) async {
    emitter(const LoadingState());
    final result = await usecase(event.parameters);
    emitter(
      result.fold(
        (l) {
          switch (l.runtimeType) {
            case UnauthorizedFailure:
              return UnauthorizedState(l as UnauthorizedFailure);
            case NotFoundFailure:
              return NotFoundState(l as NotFoundFailure);
            case TimeWindowEmptyFailure:
              return TimeWindowEmptyFailureState(l as TimeWindowEmptyFailure);
            case GeneralFailures:
              return GeneralFailureState(l as GeneralFailures);
            default:
              return GetTrendingMovieListFailureState(
                  l as TrendingMovieFailures);
          }
        },
        (r) {
          movies = r.movies.moviesResult;
          return GetTrendingMovieListSuccess(r);
        },
      ),
    );
  }

  void _mapFetchTrendingMoviesListToState(
    FetchTrendingMoviesListEvent event,
    Emitter<GeneralStates> emitter,
  ) async {
    emitter(const FetchTrendingMovieListLoading());
    final result = await usecase(event.parameters);
    emitter(
      result.fold(
        (l) {
          switch (l.runtimeType) {
            case UnauthorizedFailure:
              return UnauthorizedState(l as UnauthorizedFailure);
            case NotFoundFailure:
              return NotFoundState(l as NotFoundFailure);
            case TimeWindowEmptyFailure:
              return TimeWindowEmptyFailureState(l as TimeWindowEmptyFailure);
            case GeneralFailures:
              return GeneralFailureState(l as GeneralFailures);
            default:
              return FetchTrendingMovieListFailureState(
                  l as TrendingMovieFailures);
          }
        },
        (r) {
          r.movies.moviesResult.map((e) => movies.add(e)).toList();
          return FetchTrendingMovieListSuccess(r);
        },
      ),
    );
  }
}
