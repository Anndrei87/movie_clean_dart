import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer_result_list.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/infrastructure/models/movie_trailer_results_list.dart';

class MovieTrailerModel extends MovieTrailer {
  MovieTrailerModel({
    required int id,
    required MovieTrailerResults movieTrailerResults,
  }) : super(
          id: id,
          movieTrailerResults: movieTrailerResults,
        );

  factory MovieTrailerModel.fromJson(Map<String, dynamic> json) =>
      MovieTrailerModel(
        id: json['id'],
        movieTrailerResults: MovieTrailerResultsModel.fromJson(json['results']),
      );
}
