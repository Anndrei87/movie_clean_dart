import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_results_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_failure_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/loading_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/not_found_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/unauthorized_state.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/entities/trending_movies_request_param.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/failures/time_window_empty_failure.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/failures/trending_movies_list_failure.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/usecases/get_movies_by_time_window.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/events/fetch_movies_list_event.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/events/get_movies_list_event.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/states/trending_movies_list_states.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/trending_movies_list_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetTrendingMoviesByTimeWindowAbstractionMock extends Mock
    implements GetTrendingByTimeWindowAbstraction {}

class TrendingMovieRequestParametersFake extends Fake
    implements TrendingRequestParameters {}

final usecase = GetTrendingMoviesByTimeWindowAbstractionMock();
final bloc = GetTrendingMoviesBloc(usecase);

const TrendingRequestParameters filledParameter = TrendingRequestParameters(
  page: 1,
  language: 'pt-BR',
  locationLanguage: 'pt',
  timeWindow: 'timeWindow',
);

const TrendingRequestParameters timeWindowEmptyParameters =
    TrendingRequestParameters(
  page: 1,
  language: 'pt-BR',
  locationLanguage: 'pt',
  timeWindow: '',
);

const MovieList movieListPage = MovieList(
  movies: MovieListResults(moviesResult: []),
  page: 1,
  totalPages: 1,
  totalResults: 1,
);

void main() {
  setUpAll(() {
    registerFallbackValue(TrendingMovieRequestParametersFake());
  });

  test(
      'Should return all states in order and GetTrendingMoviesListSuccessState as final state',
      () async {
    when(() => usecase(any()))
        .thenAnswer((invocation) async => const Right(movieListPage));
    bloc.add(const GetMoviesListEvent(filledParameter));
    expect(
        bloc.stream,
        emitsInOrder(
          [isA<LoadingState>(), isA<GetTrendingMovieListSuccess>()],
        ));
  });

  test(
      'Should return all states in order and GetTrendingMoviesListFailueState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async => const Left(
        TrendingMoviesListFailure('GetTrendingMoviesListFailueState')));
    bloc.add(const GetMoviesListEvent(timeWindowEmptyParameters));
    expect(
        bloc.stream,
        emitsInOrder(
          [isA<LoadingState>(), isA<GetTrendingMovieListFailureState>()],
        ));
  });

  test(
      'Should return all states in order and TimeWindowEmptyFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(TimeWindowEmptyFailure('TimeWindowEmptyFailure')));
    bloc.add(const GetMoviesListEvent(timeWindowEmptyParameters));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<LoadingState>(), isA<TimeWindowEmptyFailureState>()]));
  });

  test(
      'Should return all states in order and UnauthorizedFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(UnauthorizedFailure('UnauthorizedFailure')));
    bloc.add(const GetMoviesListEvent(filledParameter));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<UnauthorizedState>()]));
  });

  test(
      'Should return all states in order and NotFoundFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer(
        (invocation) async => const Left(NotFoundFailure('NotFoundFailure')));
    bloc.add(const GetMoviesListEvent(filledParameter));
    expect(
        bloc.stream, emitsInOrder([isA<LoadingState>(), isA<NotFoundState>()]));
  });

  test(
      'Should return all states in order and GeneralFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer(
        (invocation) async => const Left(GeneralFailures('GeneralFailure')));
    bloc.add(const GetMoviesListEvent(filledParameter));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<GeneralFailureState>()]));
  });

  //fetch

  test(
      'Should return all states in order and GetTrendingMoviesListSuccessState as final state',
      () async {
    when(() => usecase(any()))
        .thenAnswer((invocation) async => const Right(movieListPage));
    bloc.add(const FetchTrendingMoviesListEvent(filledParameter));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchTrendingMovieListLoading>(),
          isA<FetchTrendingMovieListSuccess>()
        ]));
  });

  test(
      'Should return all states in order and GetTrendingMoviesListFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(TrendingMoviesListFailure('GetTrendingMoviesListFailure')));
    bloc.add(const FetchTrendingMoviesListEvent(filledParameter));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchTrendingMovieListLoading>(),
          isA<FetchTrendingMovieListFailureState>()
        ]));
  });

  test(
      'Should return all states in order and TimeWindowEmptyFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(TimeWindowEmptyFailure('TimeWindowEmptyFailure')));
    bloc.add(const FetchTrendingMoviesListEvent(timeWindowEmptyParameters));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchTrendingMovieListLoading>(),
          isA<TimeWindowEmptyFailureState>()
        ]));
  });

  test(
      'Should return all states in order and UnauthorizedFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(UnauthorizedFailure('UnauthorizedFailure')));
    bloc.add(const FetchTrendingMoviesListEvent(filledParameter));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<FetchTrendingMovieListLoading>(), isA<UnauthorizedState>()]));
  });

  test(
      'Should return all states in order and NotFoundFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer(
        (invocation) async => const Left(NotFoundFailure('NotFoundFailure')));
    bloc.add(const FetchTrendingMoviesListEvent(filledParameter));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<FetchTrendingMovieListLoading>(), isA<NotFoundState>()]));
  });

  test(
      'Should return all states in order and GeneralFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer(
        (invocation) async => const Left(GeneralFailures('GeneralFailure')));
    bloc.add(const FetchTrendingMoviesListEvent(filledParameter));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchTrendingMovieListLoading>(),
          isA<GeneralFailureState>()
        ]));
  });
}
