import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_results_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_failure_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/loading_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/not_found_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/unauthorized_state.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/entities/search_movie_entity.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/failures/search_movie_failure_empty.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/failures/search_movie_failure_general.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/usecases/search_movie_usecase.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/presentation/bloc/events/search_movie_events.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/presentation/bloc/search_movie_bloc.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/presentation/bloc/states/search_movie_states.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchMovieByQueryAbstractionMock extends Mock
    implements SearchMovieByQueryAbstraction {}

class SearchMovieParameterFake extends Fake implements SearchMovieParameter {}

final usecase = SearchMovieByQueryAbstractionMock();
final bloc = SearchMovieBloc(usecase);

const MovieList movieListPage = MovieList(
    movies: MovieListResults(moviesResult: []),
    page: 1,
    totalPages: 1,
    totalResults: 1);

const SearchMovieParameter filledParameter = SearchMovieParameter(
  page: 1,
  language: 'pt-BR',
  locationLanguage: 'pt',
  searchValue: 'searchValue',
);

const SearchMovieParameter searchQueryEmptyParameter = SearchMovieParameter(
  page: 1,
  language: 'pt-BR',
  locationLanguage: 'pt',
  searchValue: '',
);

void main() {
  setUp(() {
    registerFallbackValue(SearchMovieParameterFake());
  });

  test(
      'Should return all states in order and SearchMovieSuccessState as final state',
      () async {
    when(() => usecase(any()))
        .thenAnswer((invocation) async => const Right(movieListPage));
    bloc.add(const SearchMovieEvent(filledParameter));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<SearchMovieSuccessState>()]));
  });

  test(
      'Should return all states in order and SearchMovieFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(SearchMovieFailure('SearchMovieFailure')));
    bloc.add(const SearchMovieEvent(filledParameter));
    await Future.delayed(const Duration(milliseconds: 10));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<SearchMovieFailureState>()]));
  }, timeout: Timeout.none);

  test(
      'Should return all states in order and SearchMovieEmptyQueryFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(SearchMovieFailureEmpty('SearchMovieEmptyQueryFailure')));
    bloc.add(const SearchMovieEvent(searchQueryEmptyParameter));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<LoadingState>(), isA<SearchMovieFailureEmptyState>()]));
  }, timeout: Timeout.none);

  test(
      'Should return all states in order and FetchSearchMovieSuccessState as final state',
      () async {
    when(() => usecase(any()))
        .thenAnswer((invocation) async => const Right(movieListPage));
    bloc.add(const FetchSearchMovieEvent(filledParameter));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchSearchMovieLoadingState>(),
          isA<FetchSearchMovieSuccessState>()
        ]));
  });

  test(
      'Should return all states in order and FetchSearchMovieFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(SearchMovieFailure('SearchMovieFailure')));
    bloc.add(const FetchSearchMovieEvent(filledParameter));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchSearchMovieLoadingState>(),
          isA<FetchSearchMovieFailureState>()
        ]));
  });

  test(
      'Should return all states in order and SearchMovieEmptyQueryFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(SearchMovieFailureEmpty('SearchMovieEmptyQueryFailure')));
    bloc.add(const FetchSearchMovieEvent(filledParameter));
    expect(
        bloc.stream,
        emitsInOrder([
          isA<FetchSearchMovieLoadingState>(),
          isA<SearchMovieFailureEmptyState>()
        ]));
  });

  group('Created this group for test', () {
    test(
        'Should return all states in order and UnauthorizedFailureState as final state',
        () async {
      when(() => usecase(any())).thenAnswer((invocation) async =>
          const Left(UnauthorizedFailure('UnauthorizedFailure')));
      bloc.add(const SearchMovieEvent(filledParameter));
      expect(bloc.stream,
          emitsInOrder([isA<LoadingState>(), isA<UnauthorizedState>()]));
    });

    test(
        'Should return all states in order and NotFoundFailureState as final state',
        () async {
      when(() => usecase(any())).thenAnswer(
          (invocation) async => const Left(NotFoundFailure('NotFoundFailure')));
      bloc.add(const SearchMovieEvent(filledParameter));
      expect(bloc.stream,
          emitsInOrder([isA<LoadingState>(), isA<NotFoundState>()]));
    });

    test(
        'Should return all states in order and GeneralFailureState as final state',
        () async {
      when(() => usecase(any())).thenAnswer(
          (invocation) async => const Left(GeneralFailures('GeneralFailure')));
      bloc.add(const SearchMovieEvent(filledParameter));
      expect(bloc.stream,
          emitsInOrder([isA<LoadingState>(), isA<GeneralFailureState>()]));
    });

    //fetch
    test(
        'Should return all states in order and UnauthorizedFailureState as final state',
        () async {
      when(() => usecase(any())).thenAnswer((invocation) async =>
          const Left(UnauthorizedFailure('UnauthorizedFailure')));
      bloc.add(const FetchSearchMovieEvent(filledParameter));
      expect(
          bloc.stream,
          emitsInOrder(
              [isA<FetchSearchMovieLoadingState>(), isA<UnauthorizedState>()]));
    });

    test(
        'Should return all states in order and NotFoundFailureState as final state',
        () async {
      when(() => usecase(any())).thenAnswer(
          (invocation) async => const Left(NotFoundFailure('NotFoundFailure')));
      bloc.add(const FetchSearchMovieEvent(filledParameter));
      expect(
          bloc.stream,
          emitsInOrder(
              [isA<FetchSearchMovieLoadingState>(), isA<NotFoundState>()]));
    });

    test(
        'Should return all states in order and GeneralFailureState as final state',
        () async {
      when(() => usecase(any())).thenAnswer(
          (invocation) async => const Left(GeneralFailures('GeneralFailure')));
      bloc.add(const FetchSearchMovieEvent(filledParameter));
      expect(
          bloc.stream,
          emitsInOrder([
            isA<FetchSearchMovieLoadingState>(),
            isA<GeneralFailureState>()
          ]));
    });
  });
}
