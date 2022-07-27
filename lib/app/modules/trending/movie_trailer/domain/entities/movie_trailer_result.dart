class MovieTrailerResult {
  final String iso6391;
  final String iso31161;
  final String name;
  final String key;
  final String site;
  final int size;
  final String type;
  final bool isOfficial;
  final String publishDate;
  final String id;

  MovieTrailerResult(
      {required this.iso6391,
      required this.iso31161,
      required this.name,
      required this.key,
      required this.site,
      required this.size,
      required this.type,
      required this.isOfficial,
      required this.publishDate,
      required this.id});
}
