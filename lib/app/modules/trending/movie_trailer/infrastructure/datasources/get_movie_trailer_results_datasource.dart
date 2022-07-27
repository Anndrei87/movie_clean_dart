import 'package:dart_clean_movies/app/modules/trending/movie_trailer/infrastructure/models/movie_trailer_model.dart';

abstract class GetMovieTrailerDatasource {
  Future<MovieTrailerModel> call(int movieId);
}
