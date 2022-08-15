import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/failures/get_movie_trailer_failures.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/repositories/movie_trailer_repository.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/usecase/movie_trailer_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetMovieTrailerResultsRepositoryMock extends Mock
    implements MovieTrailerResultsRepository {}

class MovieTrailerFake extends Fake implements MovieTrailer {}

final repository = GetMovieTrailerResultsRepositoryMock();
final usecase = GetMovieTrailerByMovieId(repository);

void main() {
  test('Must return an MovieTrailer entity', () async {
    when(() => repository(any()))
        .thenAnswer((invocation) async => Right(MovieTrailerFake()));

    final result = await usecase(1);
    expect(result.fold(id, id), isA<MovieTrailer>());
  });

  test('Must return an GetMovieTrailerResultsFailure', () async {
    when(() => repository(any())).thenAnswer((realInvocation) async =>
        const Left(
            GetMovieTrailerResultsFailure('GetMovieTrailerResultsFailure')));
    final result = await usecase(1);
    expect(result.fold(id, id), isA<GetMovieTrailerResultsFailure>());
  });

  test('Must return an UnauthorizedFailure', () async {
    when(() => repository(any())).thenAnswer((realInvocation) async =>
        const Left(UnauthorizedFailure('UnauthorizedFailure')));
    final result = await usecase(1);
    expect(result.fold(id, id), isA<UnauthorizedFailure>());
  });

  test('Must return an NotFoundFailure', () async {
    when(() => repository(any())).thenAnswer((realInvocation) async =>
        const Left(NotFoundFailure('NotFoundFailure')));
    final result = await usecase(1);
    expect(result.fold(id, id), isA<NotFoundFailure>());
  });

  test('Must return an GeneralFailure', () async {
    when(() => repository(any())).thenAnswer((realInvocation) async =>
        const Left(GeneralFailures('GeneralFailure')));
    final result = await usecase(1);
    expect(result.fold(id, id), isA<GeneralFailures>());
  });
}
