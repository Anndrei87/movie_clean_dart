import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/general_exceptions.dart';

abstract class GetMovieTrailerExcpetions implements GeneralExceptions {
  @override
  final String messageException;

  const GetMovieTrailerExcpetions(this.messageException);
}
