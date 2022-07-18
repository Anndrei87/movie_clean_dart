import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/entities/trending_movies_request_param.dart';
import 'package:dartz/dartz.dart';

abstract class GetTrendingMoviesRepository {
  Future<Either<Failures, MovieList>> call(
      TrendingRequestParameters parameters);
}
