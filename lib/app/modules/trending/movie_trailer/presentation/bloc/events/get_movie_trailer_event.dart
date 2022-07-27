abstract class GetMovieTrailerEvents {
  const GetMovieTrailerEvents();
}

class GetMovieTrailerEvent extends GetMovieTrailerEvents {
  final int movieId;

  const GetMovieTrailerEvent(this.movieId);
}
