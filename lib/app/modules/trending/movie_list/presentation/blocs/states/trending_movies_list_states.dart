import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_states.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/failures/time_window_empty_failure.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/failures/trending_movies_failures.dart';

abstract class TrendingMovieListStates implements GeneralStates {
  const TrendingMovieListStates();
}

class FetchTrendingMovieListFailureState extends TrendingMovieListStates {
  final TrendingMovieFailures messageFailure;

  const FetchTrendingMovieListFailureState(this.messageFailure);
}

class FetchTrendingMovieListSuccess extends TrendingMovieListStates {
  final MovieList movieList;

  const FetchTrendingMovieListSuccess(this.movieList);
}

class FetchTrendingMovieListLoading extends TrendingMovieListStates {
  const FetchTrendingMovieListLoading();
}

class GetTrendingMovieListFailureState extends TrendingMovieListStates {
  final TrendingMovieFailures messageFailure;

  const GetTrendingMovieListFailureState(this.messageFailure);
}

class GetTrendingMovieListSuccess extends TrendingMovieListStates {
  final MovieList movieList;

  const GetTrendingMovieListSuccess(this.movieList);
}

class TimeWindowEmptyFailureState extends TrendingMovieListStates {
  final TimeWindowEmptyFailure timeWindowEmptyFailure;

  const TimeWindowEmptyFailureState(this.timeWindowEmptyFailure);
}
