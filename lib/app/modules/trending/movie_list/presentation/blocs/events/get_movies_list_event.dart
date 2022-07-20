import 'package:dart_clean_movies/app/modules/trending/movie_list/domain/entities/trending_movies_request_param.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_list/presentation/blocs/events/trending_movies_event.dart';

class GetMoviesListEvent extends TrendingMoviesListEvent {
  final TrendingRequestParameters parameters;

  const GetMoviesListEvent(this.parameters);
}
