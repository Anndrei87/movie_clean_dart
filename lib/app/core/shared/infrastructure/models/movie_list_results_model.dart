import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_entity.dart';
import 'package:dart_clean_movies/app/core/shared/domain/entities/movie_list_results_entity.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/models/movie_model.dart';

class MovieListResultsModel extends MovieListResults {
  MovieListResultsModel({
    required List<Movie> moviesResult,
  }) : super(
          moviesResult: moviesResult,
        );

  factory MovieListResultsModel.fromJson(List<dynamic> json) =>
      MovieListResultsModel(
        moviesResult: json.map((e) => MovieModel.fronJson(e)).toList(),
      );
}
