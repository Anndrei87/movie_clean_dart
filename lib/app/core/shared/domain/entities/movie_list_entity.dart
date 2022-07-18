import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_results_entity.dart';

class MovieList {
  final MovieListResults movies;
  final int page;
  final int totalPages;
  final int totalResults;

  const MovieList({
    required this.movies,
    required this.page,
    required this.totalPages,
    required this.totalResults,
  });
}
