import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/entities/search_movie_entity.dart';

abstract class SearchMovieEvents {
  const SearchMovieEvents();
}

class SearchMovieEvent extends SearchMovieEvents {
  final SearchMovieParameter parameter;

  const SearchMovieEvent(this.parameter);
}

class FetchSearchMovieEvent extends SearchMovieEvents {
  final SearchMovieParameter parameter;

  const FetchSearchMovieEvent(this.parameter);
}
