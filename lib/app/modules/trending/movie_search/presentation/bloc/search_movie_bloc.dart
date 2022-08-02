import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_failure_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_states.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/initial_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/loading_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/not_found_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/unauthorized_state.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/failures/search_movie_failure_empty.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/failures/search_movie_failure_general.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/usecases/search_movie_usecase.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/presentation/bloc/events/search_movie_events.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/presentation/bloc/states/search_movie_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvents, GeneralStates>
    implements Disposable {
  final SearchMovieByQueryAbstraction usecase;

  SearchMovieBloc(this.usecase) : super(const InitialState()) {
    on<SearchMovieEvent>(
      _mapSearchMovieToState,
      transformer: (event, mapper) => event
          .debounceTime(const Duration(milliseconds: 400))
          .switchMap(mapper),
    );
    on<FetchSearchMovieEvent>(_mapFetchSearchMovieToState);
  }

  List<Movie> movies = [];
  bool lastPage = false;
  int page = 1;

  @override
  void dispose() => close();

  void _mapSearchMovieToState(
      SearchMovieEvent event, Emitter<GeneralStates> emitter) async {
    movies.clear();
    emitter(const LoadingState());
    final result = await usecase(event.parameter);
    emitter(result.fold((l) {
      switch (l.runtimeType) {
        case UnauthorizedFailure:
          return UnauthorizedState(l as UnauthorizedFailure);
        case NotFoundFailure:
          return NotFoundState(l as NotFoundFailure);
        case SearchMovieFailureEmpty:
          return SearchMovieFailureEmptyState(l as SearchMovieFailureEmpty);
        case GeneralFailures:
          return GeneralFailureState(l as GeneralFailures);
        default:
          return SearchMovieFailureState(l as SearchMovieFailure);
      }
    }, (r) {
      movies = r.movies.moviesResult;
      return SearchMovieSuccessState(r);
    }));
  }

  void _mapFetchSearchMovieToState(
      FetchSearchMovieEvent event, Emitter<GeneralStates> emitter) async {
    emitter(const FetchSearchMovieLoadingState());
    final result = await usecase(event.parameter);
    emitter(
      result.fold(
        (l) {
          switch (l.runtimeType) {
            case UnauthorizedFailure:
              return UnauthorizedState(l as UnauthorizedFailure);
            case NotFoundFailure:
              return NotFoundState(l as NotFoundFailure);
            case SearchMovieFailureEmpty:
              return SearchMovieFailureEmptyState(l as SearchMovieFailureEmpty);
            case GeneralFailures:
              return GeneralFailureState(l as GeneralFailures);
            default:
              return FetchSearchMovieFailureState(l as SearchMovieFailure);
          }
        },
        (r) {
          if (r.movies.moviesResult.length < 20) {
            lastPage = true;
          } else {
            lastPage = false;
          }
          r.movies.moviesResult.map((e) => movies.add(e)).toList();
          return FetchSearchMovieSuccessState(r);
        },
      ),
    );
  }
}
