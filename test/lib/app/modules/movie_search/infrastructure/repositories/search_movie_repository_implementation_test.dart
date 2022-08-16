import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/models/movie_list_model.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/entities/search_movie_entity.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/failures/search_movie_failure_general.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/infrastructure/datasource/search_movie_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/infrastructure/exceptions/search_movie_datasource_exception.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/infrastructure/repositories/search_movie_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchMovieDatasourceMock extends Mock implements SearchMovieDatasource {}

class MovieListPageModelFake extends Fake implements MovieListModel {}

class SearchMovieParameterFake extends Fake implements SearchMovieParameter {}

final datasource = SearchMovieDatasourceMock();
final repository = SearchMovieRepositoryImplementation(datasource);

const SearchMovieParameter filledParameter = SearchMovieParameter(
  page: 1,
  language: 'pt-BR',
  searchValue: 'searchValue',
  locationLanguage: '',
);

void main() {
  setUpAll(() {
    registerFallbackValue(SearchMovieParameterFake());
  });

  test('Must return an MovieList entity', () async {
    when(() => datasource(any()))
        .thenAnswer((invocation) async => MovieListPageModelFake());
    final result = await repository(filledParameter);
    expect(result.fold(id, id), isA<MovieList>());
  });

  test('must return an SearchMovieFailure', () async {
    when(() => datasource(any())).thenThrow(
        const SearchMovieDataSourceException('SearchMovieDatasourceException'));
    final result = await repository(filledParameter);
    expect(result.fold(id, id), isA<SearchMovieFailure>());
  });

  test('must return an UnauthorizedFailure', () async {
    when(() => datasource(any()))
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
