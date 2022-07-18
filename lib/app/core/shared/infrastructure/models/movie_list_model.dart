import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_results_entity.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/models/movie_list_results_model.dart';

class MovieListModel extends MovieList {
  MovieListModel({
    required MovieListResults movies,
    required int page,
    required int totalPages,
    required int totalResults,
  }) : super(
          movies: movies,
          page: page,
          totalPages: totalPages,
          totalResults: totalResults,
        );

  factory MovieListModel.fromJson(Map<String, dynamic> json) => MovieListModel(
        movies: MovieListResultsModel.fromJson(json['results']),
        page: json['page'],
        totalPages: json['total_pages'],
        totalResults: json['total_results'],
      );
}
