import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/entities/search_movie_entity.dart';
import 'package:dartz/dartz.dart';

abstract class SearchMovieRepository {
  Future<Either<Failures, MovieList>> call(SearchMovieParameter parameters);
}
