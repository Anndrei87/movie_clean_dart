import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/models/movie_list_model.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/entities/trending_movies_request_param.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/failures/trending_movies_list_failure.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/infrastructure/datasources/get_trending_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/infrastructure/exceptions/get_trending_movies.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/infrastructure/repositories/get_trendings_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class GetMovieDataSourceMock extends Mock implements GetTrendingDataSource {}

class MovieListModelPageFake extends Fake implements MovieListModel {}

class TrendingMoviesParametersFake extends Fake
    implements TrendingRequestParameters {}

final datasource = GetMovieDataSourceMock();
final repository = GetTrendingMoviesRepositoryImplementation(datasource);

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
    when(() => datasource(any()))
        .thenAnswer((invocation) async => MovieListModelPageFake());
    final result = await repository(filledParameter);
    expect(result.fold(id, id), isA<MovieList>());
  });

  test('Must return an GetTrendingMoviesListFailure', () async {
    when((() => datasource(any()))).thenThrow(
        const GetTrendingMovieListException(
            'GetTrendingMoviesListDatasourceError'));
    final result = await repository(filledParameter);
    expect(result.fold(id, id), isA<TrendingMoviesListFailure>());
  });

  test('Must return an UnauthorizedFailure', () async {
    when((() => datasource(any())))
        .thenThrow(const UnauthorizedDataSource('UnauthorizedDatasourceError'));
    final result = await repository(filledParameter);
    expect(result.fold(id, id), isA<UnauthorizedFailure>());
  });

  test('must return an NotFoundFailure', () async {
    when(() => datasource(any())).thenThrow(
        const NotFoundDataSourceException('NotFoundDatasourceError'));
    final result = await repository(filledParameter);
    expect(result.fold(id, id), isA<NotFoundFailure>());
  });

  test('must return an GeneralFailure', () async {
    when(() => datasource(any())).thenThrow(Exception('Exception'));
    final result = await repository(filledParameter);
    expect(result.fold(id, id), isA<GeneralFailures>());
  });
}
