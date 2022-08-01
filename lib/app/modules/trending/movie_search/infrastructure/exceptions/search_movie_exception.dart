import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/general_exceptions.dart';

abstract class SearchMovieException implements GeneralExceptions {
  @override
  final String messageException;

  const SearchMovieException(this.messageException);
}
