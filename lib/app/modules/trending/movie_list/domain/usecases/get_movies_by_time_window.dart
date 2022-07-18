import 'package:dart_clean_movies/app/core/shared/domain/failures/faliures.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/entities/trending_movies_request_param.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/failures/time_window_empty_failure.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/repositories/get_trending_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/shared/domain/entities/movie_list_entity.dart';

abstract class GetTrendingByTimeWindowAbstraction {
  Future<Either<Failures, MovieList>> call(TrendingRequestParameters parameter);
}

class GetTrendingByTimeWindow implements GetTrendingByTimeWindowAbstraction {
  final GetTrendingMoviesRepository repository;

  const GetTrendingByTimeWindow(this.repository);
  @override
  Future<Either<Failures, MovieList>> call(
          TrendingRequestParameters parameter) async =>
      parameter.timeWindow.isEmpty
          ? const Left(TimeWindowEmptyFailure(
              'Selecione a janela de tempo para exibir a listagem'))
          : await repository(parameter);
}
