import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer_result_list.dart';

class MovieTrailer {
  final int id;
  final MovieTrailerResults movieTrailerResults;

  MovieTrailer({required this.id, required this.movieTrailerResults});
}
