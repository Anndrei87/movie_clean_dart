import 'package:dart_clean_movies/app/core/packages/http_client.dart';
import 'package:dart_clean_movies/app/core/packages/http_response.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/models/movie_list_model.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/entities/search_movie_entity.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/external/datasource/search_movie_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/infrastructure/exceptions/search_movie_datasource_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../movie_list/external/mocks/get_movie_not_found_test.dart';
import '../../../movie_list/external/mocks/get_movie_success_test.dart';
import '../../../movie_list/external/mocks/get_movie_unauthorized_test.dart';

class DioClientMock extends Mock implements RequestClient {}

class SearchMovieParameterFake extends Fake implements SearchMovieParameter {}

final requestClient = DioClientMock();
final datasource = SearchMovieDataSourceImp(requestClient);

const SearchMovieParameter filledParameter = SearchMovieParameter(
  page: 1,
  language: 'pt-BR',
  locationLanguage: 'pt',
  searchValue: 'searchValue',
);

void main() {
  setUp(() {
    registerFallbackValue(SearchMovieParameterFake());
  });

  test('Must complete the request', () {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceSuccessResponse, statusCode: 200));
    final result = datasource(filledParameter);
    expect(result, completes);
  });

  test('Must return an MovieListModel', () async {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceSuccessResponse, statusCode: 200));
    final result = await datasource(filledParameter);
    expect(result, isA<MovieListModel>());
  });

  test('Must throw an SearchMovieDatasourceException', () async {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceSuccessResponse, statusCode: 500));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<SearchMovieDataSourceException>()));
  });

  test('Must throw an NotFoundDatasourceException', () async {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceNotFoundResponse,
            statusCode: 404));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<NotFoundDataSourceException>()));
  });

  test('Must throw an UnauthorizedDatasourceException', () async {
    when(() => requestClient.get(any())).thenAnswer((realInvocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceUnauthorizedResponse,
            statusCode: 401));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<UnauthorizedDataSource>()));
  });

  test('Must throw an SearchMovieDatasourceException', () async {
    when(() => requestClient.get(any())).thenThrow(
        const SearchMovieDataSourceException('SearchMovieDatasourceException'));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<SearchMovieDataSourceException>()));
  });

  test('Must throw an UnauthorizedDatasourceException', () async {
    when(() => requestClient.get(any())).thenThrow(
        const UnauthorizedDataSource('UnauthorizedDatasourceException'));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<UnauthorizedDataSource>()));
  });

  test('Must throw an NotFoundDatasourceException', () async {
    when(() => requestClient.get(any())).thenThrow(
        const NotFoundDataSourceException('NotFoundDatasourceException'));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<NotFoundDataSourceException>()));
  });
}
