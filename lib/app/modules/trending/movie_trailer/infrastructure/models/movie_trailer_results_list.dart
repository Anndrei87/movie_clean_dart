import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer_result.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer_result_list.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/infrastructure/models/movie_trailer_result.dart';

class MovieTrailerResultsModel extends MovieTrailerResults {
  MovieTrailerResultsModel({
    required List<MovieTrailerResult> results,
  }) : super(
          results: results,
        );

  factory MovieTrailerResultsModel.fromJson(List<dynamic> json) =>
      MovieTrailerResultsModel(
        results: json.map((e) => MovieTrailerResultModel.fromJson(e)).toList(),
      );
}
