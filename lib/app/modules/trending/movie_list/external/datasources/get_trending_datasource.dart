import 'package:dart_clean_movies/app/core/config/config.dart';
import 'package:dart_clean_movies/app/core/packages/http_client.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/entities/trending_movies_request_param.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/models/movie_list_model.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/external/settings/get_trending_settings.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/infrastructure/datasources/get_trending_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/infrastructure/exceptions/get_trending_movies.dart';

class GetTrendingDataSourceImplementation implements GetTrendingDataSource {
  final RequestClient requestClient;

  const GetTrendingDataSourceImplementation(this.requestClient);

  @override
  Future<MovieListModel> call(TrendingRequestParameters parameters) async {
    final response = await requestClient.get("${ServerConfiguration.serverHost}"
        "${GetTrendingMovieSettings.output}"
        "${parameters.timeWindow}"
        "?api_key=${ServerConfiguration.apiKey}"
        "&page=${parameters.page}"
        "&language=${parameters.language}"
        "&include_image_language=${parameters.locationLanguage}");

    switch (response.statusCode) {
      case 200:
        return MovieListModel.fromJson(response.data);
      case 401:
        throw UnauthorizedDataSource(response.data['status_message']);
      case 404:
        throw NotFoundDataSource(response.data['status_message']);
      default:
        throw const GetTrendingMovieListException('Houve um erro interno');
    }
  }
}
