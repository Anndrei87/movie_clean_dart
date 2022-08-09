import 'package:dart_clean_movies/app/core/config/config.dart';
import 'package:dart_clean_movies/app/core/packages/http_client.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/domain/entities/search_movie_entity.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/models/movie_list_model.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/external/settings/search_movie_settings.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/infrastructure/datasource/search_movie_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_search/infrastructure/exceptions/search_movie_datasource_exception.dart';

class SearchMovieDataSourceImp implements SearchMovieDatasource {
  final RequestClient requestClient;

  const SearchMovieDataSourceImp(this.requestClient);
  @override
  Future<MovieListModel> call(SearchMovieParameter parameter) async {
    final response = await requestClient.get("${ServerConfiguration.serverHost}"
        "${SearchMovieSettings.output}"
        "?query=${parameter.searchValue}"
        "&api_key=${ServerConfiguration.apiKey}"
        "&page=${parameter.page}"
        "&language=${parameter.language}"
        "&include_image_language=${parameter.locationLanguage}");
    switch (response.statusCode) {
      case 200:
        return MovieListModel.fromJson(response.data);
      case 401:
        throw UnauthorizedDataSource(response.data['status_message']);
      case 404:
        throw NotFoundDataSourceException(response.data['status_message']);
      default:
        throw const SearchMovieDataSourceException('Houve um erro interno');
    }
  }
}
