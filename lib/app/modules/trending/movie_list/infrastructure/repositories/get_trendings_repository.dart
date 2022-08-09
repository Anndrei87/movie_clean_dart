import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/entities/trending_movies_request_param.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';
import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/failures/trending_movies_list_failure.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/repositories/get_trending_repository.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/infrastructure/datasources/get_trending_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/infrastructure/exceptions/get_trending_movies.dart';
import 'package:dartz/dartz.dart';

class GetTrendingMoviesRepositoryImplementation
    implements GetTrendingMoviesRepository {
  final GetTrendingDataSource dataSource;

  const GetTrendingMoviesRepositoryImplementation(this.dataSource);
  @override
  Future<Either<Failures, MovieList>> call(
      TrendingRequestParameters parameters) async {
    try {
      return Right(await dataSource(parameters));
    } on GetTrendingMovieListException catch (e) {
      return Left(TrendingMoviesListFailure(e.messageException));
    } on UnauthorizedDataSource catch (e) {
      return Left(UnauthorizedFailure(e.messageException));
    } on NotFoundDataSourceException catch (e) {
      return Left(NotFoundFailure(e.messageException));
    } on Exception catch (e) {
      return Left(GeneralFailures(e.toString()));
    }
  }
}
