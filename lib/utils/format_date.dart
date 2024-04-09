import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class FormatDate {
  FormatDate() {
    initializeDateFormatting();
    Intl.defaultLocale = 'pt_BR';
  }

  static DateTime newDate() => DateTime.now();

  static String formatDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

  static String formatDateWek(String date) =>
      date != '' ? DateFormat("EEEE - MMMM").format(dateParse(date)).replaceAll("-feira", "") : '';

  static String formatDateString(String date) =>
      date != '' ? DateFormat("dd/MM/yy").format(dateParse(date)) : '';

  static String formatDateStringDb(String date) =>
      date != '' ? DateFormat("dd/MM/yyyy").format(dateParse(date)) : '';

  static String formatDateStringNotification(DateTime date) => DateFormat('dd/MM/yyyy hh:mm:ss').format(date);

  static DateTime dateParse(String date) => DateFormat('dd/MM/yyyy').parse(date);

  static DateTime dateParseAlert(String date) => DateFormat('yyyy-MM-dd hh:mm:ss').parse(date);

  static String formatTimeString(String time) =>
      time != '' ? DateFormat("hh:mm").format(timeParse(time)) : '';

  static DateTime timeParse(String date) => DateFormat('hh:mm').parse(date);

  static String formatTimeByString(DateTime date) => DateFormat('hh:mm').format(date);
}
