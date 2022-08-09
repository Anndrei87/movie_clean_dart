import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/entities/trending_movies_request_param.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/failures/time_window_empty_failure.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/repositories/get_trending_repository.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/usecases/get_movies_by_time_window.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetTrendingMoviesRepositoryMock extends Mock
    implements GetTrendingMoviesRepository {}

class MovieListPageFake extends Fake implements MovieList {}

class TrendingMoviesParametersFake extends Fake
    implements TrendingRequestParameters {}

final repository = GetTrendingMoviesRepositoryMock();
final usecase = GetTrendingByTimeWindow(repository);

const TrendingRequestParameters filledParameter = TrendingRequestParameters(
  page: 1,
  language: 'pt-BR',
  locationLanguage: 'pt',
  timeWindow: 'timeWindow',
);

void main() {
  setUpAll(() {
    registerFallbackValue(TrendingMoviesParametersFake());
  });

  test('Must return an MovieList entity', () async {
    when(() => repository(any()))
        .thenAnswer((realInvocation) async => Right(MovieListPageFake()));
    final result = await usecase(filledParameter);
    expect(result.fold(id, id), isA<MovieList>());
  });

  test('Must return an TimeWindowEmptyFailure', () async {
    const TrendingRequestParameters timeWindowEmptyParameter =
        TrendingRequestParameters(
      page: 1,
      language: 'pt-BR',
      locationLanguage: 'pt',
      timeWindow: '',
    );
    when(() => repository(any())).thenAnswer(
      (realInvocation) async => const Left(
        TimeWindowEmptyFailure('TimeWindowEmptyFailure'),
      ),
    );
    final result = await usecase(timeWindowEmptyParameter);
    expect(result.fold(id, id), isA<TimeWindowEmptyFailure>());
  });

  test('Must return an UnauthorizedFailure', () async {
    when(() => repository(any())).thenAnswer((realInvocation) async =>
        const Left(UnauthorizedFailure('UnauthorizedFailure')));
    final result = await usecase(filledParameter);
    expect(result.fold(id, id), isA<UnauthorizedFailure>());
  });

  test('Must return an NotFoundFailure', () async {
    when(() => repository(any())).thenAnswer((realInvocation) async =>
        const Left(NotFoundFailure('NotFoundFailure')));
    final result = await usecase(filledParameter);
    expect(result.fold(id, id), isA<NotFoundFailure>());
  });

  test('Must return an GeneralFailure', () async {
    when(() => repository(any())).thenAnswer((realInvocation) async =>
        const Left(GeneralFailures('GeneralFailure')));
    final result = await usecase(filledParameter);
    expect(result.fold(id, id), isA<GeneralFailures>());
  });
}
