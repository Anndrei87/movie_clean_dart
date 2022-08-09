import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/failures/get_movie_trailer_failures.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/repositories/movie_trailer_repository.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/infrastructure/datasources/get_movie_trailer_results_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/infrastructure/exceptions/get_movie_datasource_exception.dart';
import 'package:dartz/dartz.dart';

class GetMovieTrailerResultsRepositoryImplementation
    implements MovieTrailerResultsRepository {
  final GetMovieTrailerDatasource datasource;

  const GetMovieTrailerResultsRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failures, MovieTrailer>> call(int movieId) async {
    try {
      return Right(await datasource(movieId));
    } on GetMovieTrailerDatasourceException catch (e) {
      return Left(GetMovieTrailerResultsFailure(e.messageException));
    } on UnauthorizedDataSource catch (e) {
      return Left(UnauthorizedFailure(e.messageException));
    } on NotFoundDataSourceException catch (e) {
      return Left(NotFoundFailure(e.messageException));
    } on Exception catch (e) {
      return Left(GeneralFailures(e.toString()));
    }
  }
}
