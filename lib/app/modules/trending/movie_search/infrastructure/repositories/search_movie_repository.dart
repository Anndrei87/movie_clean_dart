import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/general_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/not_found_failure.dart';
import 'package:dart_clean_movies/app/core/shared/domain/failures/unauthorized_failure.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/entities/search_movie_entity.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/failures/search_movie_failure_general.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/repositories/search_movie_repository.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/infrastructure/datasource/search_movie_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/infrastructure/exceptions/search_movie_datasource_exception.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/shared/domain/failures/faliures.dart';

class SearchMovieRepositoryImplementation implements SearchMovieRepository {
  final SearchMovieDatasource datasource;

  const SearchMovieRepositoryImplementation(this.datasource);
  @override
  Future<Either<Failures, MovieList>> call(
      SearchMovieParameter parameters) async {
    try {
      return Right(await datasource(parameters));
    } on SearchMovieDataSourceException catch (e) {
      return Left(SearchMovieFailure(e.messageException));
    } on UnauthorizedDataSource catch (e) {
      return Left(UnauthorizedFailure(e.messageException));
    } on NotFoundDataSourceException catch (e) {
      return Left(NotFoundFailure(e.messageException));
    } on Exception catch (e) {
      return Left(GeneralFailures(e.toString()));
    }
  }
}
