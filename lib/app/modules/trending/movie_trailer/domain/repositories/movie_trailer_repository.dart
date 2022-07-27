import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer.dart';
import 'package:dartz/dartz.dart';

abstract class MovieTrailerResultsRepository {
  Future<Either<Failures, MovieTrailer>> call(int movieId);
}
