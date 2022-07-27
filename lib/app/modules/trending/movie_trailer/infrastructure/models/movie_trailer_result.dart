import 'package:dart_clean_movies/app/modules/trending/movie_trailer/domain/entities/movie_trailer_result.dart';

class MovieTrailerResultModel extends MovieTrailerResult {
  MovieTrailerResultModel({
    required String iso6391,
    required String iso31161,
    required String name,
    required String key,
    required String site,
    required int size,
    required String type,
    required bool isOfficial,
    required String publishDate,
    required String id,
  }) : super(
          iso6391: iso6391,
          iso31161: iso31161,
          name: name,
          key: key,
          site: site,
          size: size,
          type: type,
          isOfficial: isOfficial,
          publishDate: publishDate,
          id: id,
        );

  factory MovieTrailerResultModel.fromJson(Map<String, dynamic> json) =>
      MovieTrailerResultModel(
        iso6391: json['iso_639_1'],
        iso31161: json['iso_3166_1'],
        name: json['name'],
        key: json['key'],
        site: json['site'],
        size: json['size'],
        type: json['type'],
        isOfficial: json['official'],
        publishDate: json['published_at'],
        id: json['iso_639_1'],
      );
}
