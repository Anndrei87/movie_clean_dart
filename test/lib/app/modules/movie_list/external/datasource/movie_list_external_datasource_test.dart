import 'dart:io';

import 'package:dart_clean_movies/app/core/packages/http_client.dart';
import 'package:dart_clean_movies/app/core/packages/http_response.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/models/movie_list_model.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/entities/trending_movies_request_param.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/external/datasources/get_trending_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/infrastructure/exceptions/get_trending_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../mocks/get_movie_not_found_test.dart';
import '../mocks/get_movie_success_test.dart';
import '../mocks/get_movie_unauthorized_test.dart';

class DioClientMock extends Mock implements RequestClient {}

class TrendingMoviesParametersFake extends Fake
    implements TrendingRequestParameters {}

final requestClient = DioClientMock();
final datasource = GetTrendingDataSourceImplementation(requestClient);

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

  test('Must complete the request', () {
    when(() => requestClient.get(any())).thenAnswer((invocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceSuccessResponse, statusCode: 200));
    final result = datasource(filledParameter);
    expect(result, completes);
  });

  test('Must return an MovieListModel', () async {
    when(() => requestClient.get(any())).thenAnswer((invocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceSuccessResponse, statusCode: 200));
    final result = await datasource(filledParameter);
    expect(result, isA<MovieListModel>());
  });

  test('Must throw an GetTrendingMoviesDataSourceException using Http',
      () async {
    when(() => requestClient.get(any())).thenAnswer((invocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceSuccessResponse, statusCode: 500));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<GetTrendingMovieListException>()));
  });

  test('Must throw an NotFoundDataSourceException using Http', () async {
    when(() => requestClient.get(any())).thenAnswer((invocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceNotFoundResponse,
            statusCode: HttpStatus.notFound));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<NotFoundDataSourceException>()));
  });

  test('Must throw an UnauthorizedDatasourceException using Http', () async {
    when(() => requestClient.get(any())).thenAnswer((invocation) async =>
        const HttpResponse(
            data: getTrendingMoviesDatasourceUnauthorizedResponse,
            statusCode: 401));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<UnauthorizedDataSource>()));
  });

  test('Must throw an GetTrendingMoviesListDatasourceException using throw',
      () async {
    when(() => requestClient.get(any())).thenThrow(
        const GetTrendingMovieListException(
            'GetTrendingMoviesListDatasourceException'));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<GetTrendingMovieListException>()));
  });

  test('Must throw an UnauthorizedDatasourceException using throw', () async {
    when(() => requestClient.get(any())).thenThrow(
        const UnauthorizedDataSource('UnauthorizedDatasourceException'));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<UnauthorizedDataSource>()));
  });

  test('Must throw an NotFoundException using throw', () {
    when(() => requestClient.get(any())).thenThrow(
        const NotFoundDataSourceException('NotFoundDatasourceException'));
    final result = datasource(filledParameter);
    expect(result, throwsA(isA<NotFoundDataSourceException>()));
  });
}
