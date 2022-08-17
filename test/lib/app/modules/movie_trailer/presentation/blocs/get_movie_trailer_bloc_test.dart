import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_failure_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/loading_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/not_found_state.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/unauthorized_state.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer_result_list.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/failures/get_movie_trailer_failures.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/usecase/movie_trailer_usecase.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/presentation/bloc/events/get_movie_trailer_event.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/presentation/bloc/get_trailer_movie_bloc.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/presentation/bloc/states/get_movie_trailer_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetMovieTrailerByMovieIdAbstractionMock extends Mock
    implements GetMovieTrailerByMovieIdAbstraction {}

final usecase = GetMovieTrailerByMovieIdAbstractionMock();
final bloc = GetMovieTrailerBloc(usecase);

final MovieTrailer movieTrailer =
    MovieTrailer(id: 1, movieTrailerResults: MovieTrailerResults(results: []));

void main() {
  test(
      'Should return all states in order and GetMovieTrailerSuccessState as final state',
      () async {
    when(() => usecase(any()))
        .thenAnswer((invocation) async => Right(movieTrailer));
    bloc.add(const GetMovieTrailerEvent(1));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<LoadingState>(), isA<GetMovieTrailerSuccessState>()]));
  });

  test(
      'Should return all states in order and GetMovieTrailerFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async => const Left(
        GetMovieTrailerResultsFailure('GetMovieTrailerResultsFailure')));
    bloc.add(const GetMovieTrailerEvent(1));
    expect(
        bloc.stream,
        emitsInOrder(
            [isA<LoadingState>(), isA<GetMovieTrailerFailureState>()]));
  });

  test(
      'Should return all states in order and UnauthorizedFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer((invocation) async =>
        const Left(UnauthorizedFailure('UnauthorizedFailure')));
    bloc.add(const GetMovieTrailerEvent(1));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<UnauthorizedState>()]));
  });

  test(
      'Should return all states in order and NotFoundFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer(
        (invocation) async => const Left(NotFoundFailure('NotFoundFailure')));
    bloc.add(const GetMovieTrailerEvent(1));
    expect(
        bloc.stream, emitsInOrder([isA<LoadingState>(), isA<NotFoundState>()]));
  });

  test(
      'Should return all states in order and GeneralFailureState as final state',
      () async {
    when(() => usecase(any())).thenAnswer(
        (invocation) async => const Left(GeneralFailures('GeneralFailure')));
    bloc.add(const GetMovieTrailerEvent(1));
    expect(bloc.stream,
        emitsInOrder([isA<LoadingState>(), isA<GeneralFailureState>()]));
  });
}
