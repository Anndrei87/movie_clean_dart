import 'package:dart_clean_movies/app/core/shared/infrastructure/models/movie_list_model.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/entities/trending_movies_request_param.dart';

abstract class GetTrendingDataSource {
  Future<MovieListModel> call(TrendingRequestParameters parameters);
}
