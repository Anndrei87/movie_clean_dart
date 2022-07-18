import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/general_exceptions.dart';

class NotFoundDataSource implements GeneralExceptions {
  @override
  final String messageException;

  const NotFoundDataSource(this.messageException);
}
