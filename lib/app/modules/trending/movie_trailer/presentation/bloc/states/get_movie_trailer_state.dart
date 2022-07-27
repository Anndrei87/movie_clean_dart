import 'package:dart_clean_movies/app/core/shared/presentation/bloc/states/general_states.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer.dart';
import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/failures/get_movie_trailer_failures.dart';

abstract class GetMovieTrailerStates implements GeneralStates {
  const GetMovieTrailerStates();
}

class GetMovieTrailerFailureState extends GetMovieTrailerStates {
  final GetMovieTrailerResultsFailure failure;

  GetMovieTrailerFailureState(this.failure);
}

class GetMovieTrailerSuccessState extends GetMovieTrailerStates {
  final MovieTrailer movieTrailer;

  const GetMovieTrailerSuccessState(this.movieTrailer);
}
