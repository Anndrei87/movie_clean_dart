import 'package:intl/intl.dart';

class DateTimeHelper {
  static String convertDateFromString(String date) =>
      DateFormat('dd/MM/yyyy').format(
        DateTime.parse(date),
      );
}
