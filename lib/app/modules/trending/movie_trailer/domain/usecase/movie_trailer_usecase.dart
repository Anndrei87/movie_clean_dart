import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/repositories/movie_trailer_repository.dart';
import 'package:dartz/dartz.dart';

abstract class GetMovieTrailerByMovieIdAbstraction {
  Future<Either<Failures, MovieTrailer>> call(int movieId);
}

class GetMovieTrailerByMovieId implements GetMovieTrailerByMovieIdAbstraction {
  final MovieTrailerResultsRepository repository;

  const GetMovieTrailerByMovieId(this.repository);

  @override
  Future<Either<Failures, MovieTrailer>> call(int movieId) async =>
      await repository(movieId);
}
