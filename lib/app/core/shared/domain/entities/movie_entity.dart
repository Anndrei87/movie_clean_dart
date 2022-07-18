class Movie {
  final String releaseDate;
  final String originalLanguage;
  final int id;
  final String posterPath;
  final bool haveVideo;
  final double voteAverage;
  final String title;
  final int voteCount;
  final List<int> genreIds;
  final String originalTitle;
  final String backdropPath;
  final bool isAdult;
  final String overview;
  final double popularity;
  final String mediaType;

  const Movie({
    required this.releaseDate,
    required this.originalLanguage,
    required this.id,
    required this.posterPath,
    required this.haveVideo,
    required this.voteAverage,
    required this.title,
    required this.voteCount,
    required this.genreIds,
    required this.originalTitle,
    required this.backdropPath,
    required this.isAdult,
    required this.overview,
    required this.popularity,
    required this.mediaType,
  });
}
