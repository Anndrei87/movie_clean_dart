import 'package:dart_clean_movies/app/core/shared/infrastructure/exceptions/general_exceptions.dart';

class UnauthorizedDataSource implements GeneralExceptions {
  @override
  final String messageException;

  const UnauthorizedDataSource(this.messageException);
}
