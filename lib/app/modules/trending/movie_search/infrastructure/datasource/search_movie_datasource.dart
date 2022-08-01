import 'package:dart_clean_movies/app/core/shared/infrastructure/models/movie_list_model.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/entities/search_movie_entity.dart';

abstract class SearchMovieDatasource {
  Future<MovieListModel> call(SearchMovieParameter parameter);
}
