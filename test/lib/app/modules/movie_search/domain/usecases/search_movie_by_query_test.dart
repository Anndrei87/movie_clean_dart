import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/entities/search_movie_entity.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/failures/search_movie_failure_empty.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/repositories/search_movie_repository.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/usecases/search_movie_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class SearchMovieRepositoryMock extends Mock implements SearchMovieRepository {}

class MovieListPageFake extends Fake implements MovieList {}

class SearchMovieParameterFake extends Fake implements SearchMovieParameter {}

final repository = SearchMovieRepositoryMock();
final usecase = SearchMovieByQuery(repository);

const SearchMovieParameter filledParameter = SearchMovieParameter(
  page: 1,
  language: 'pt-BR',
  searchValue: 'searchValue',
  locationLanguage: '',
);

const SearchMovieParameter queryEmptyParameter = SearchMovieParameter(
  page: 1,
  language: 'pt-BR',
  searchValue: '',
  locationLanguage: '',
);

void main() {
  setUpAll(() {
    registerFallbackValue(SearchMovieParameterFake());
  });

  test('Must return an MovieList entity', () async {
    when(() => repository(any()))
        .thenAnswer((realInvocation) async => Right(MovieListPageFake()));
    final result = await usecase(filledParameter);
    expect(result.fold(id, id), isA<MovieList>());
  });

  test('Must return an SearchMovieEmptyQueryFailure', () async {
    when(() => repository(any())).thenAnswer((realInvocation) async =>
        const Left(SearchMovieFailureEmpty('SearchMovieEmptyQueryFailure')));
    final result = await usecase(queryEmptyParameter);
    expect(result.fold(id, id), isA<SearchMovieFailureEmpty>());
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
