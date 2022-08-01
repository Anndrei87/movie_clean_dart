import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/entities/search_movie_entity.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/failures/search_movie_failure_empty.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/repositories/search_movie_repository.dart';
import 'package:dartz/dartz.dart';

abstract class SearchMovieByQueryAbstraction {
  Future<Either<Failures, MovieList>> call(SearchMovieParameter parametes);
}

class SearchMovieByQuery implements SearchMovieByQueryAbstraction {
  final SearchMovieRepository repository;

  SearchMovieByQuery(this.repository);

  @override
  Future<Either<Failures, MovieList>> call(
          SearchMovieParameter parameters) async =>
      parameters.searchValue.isEmpty
          ? const Left(SearchMovieFailureEmpty('Digite algo para buscar'))
          : await repository(parameters);
}
