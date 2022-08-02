import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_states.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/states/trending_movies_list_states.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/failures/search_movie_failure_empty.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/failures/search_movie_failure_general.dart';

abstract class SearchMovieState implements GeneralStates {
  const SearchMovieState();
}

class SearchMovieSuccessState extends SearchMovieState {
  final MovieList movieList;

  const SearchMovieSuccessState(this.movieList);
}

class SearchMovieFailureState extends SearchMovieState {
  final SearchMovieFailure failure;

  SearchMovieFailureState(this.failure);
}

class SearchMovieFailureEmptyState extends SearchMovieState {
  final SearchMovieFailureEmpty failure;

  SearchMovieFailureEmptyState(this.failure);
}

class FetchSearchMovieFailureState extends TrendingMovieListStates {
  final SearchMovieFailure failure;

  const FetchSearchMovieFailureState(this.failure);
}

class FetchSearchMovieLoadingState extends TrendingMovieListStates {
  const FetchSearchMovieLoadingState();
}

class FetchSearchMovieSuccessState extends SearchMovieState {
  final MovieList movieList;

  const FetchSearchMovieSuccessState(this.movieList);
}
