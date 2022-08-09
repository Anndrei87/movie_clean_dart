import 'package:dart_clean_movies/app/core/config/config.dart';
import 'package:dart_clean_movies/app/core/packages/http_client.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/not_found_datasource_exception.dart';
import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/unauthorized_datasource_exception.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/infrastructure/datasources/get_movie_trailer_results_datasource.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/infrastructure/exceptions/get_movie_datasource_exception.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/infrastructure/models/movie_trailer_model.dart';

class GetMovieTrailerResultsDataSourceImplementation
    implements GetMovieTrailerDatasource {
  final RequestClient requestClient;

  const GetMovieTrailerResultsDataSourceImplementation(this.requestClient);

  @override
  Future<MovieTrailerModel> call(int movieId) async {
    final response = await requestClient.get("${ServerConfiguration.serverHost}"
        "movie/"
        "$movieId"
        "/videos"
        "?api_key=${ServerConfiguration.apiKey}");

    switch (response.statusCode) {
      case 200:
        return MovieTrailerModel.fromJson(response.data);
      case 401:
        throw UnauthorizedDataSource(response.data['status_message']);
      case 404:
        throw NotFoundDataSourceException(response.data['status_message']);
      default:
        throw const GetMovieTrailerDatasourceException('Houve um erro interno');
    }
  }
}
