import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class FormatDate {
  FormatDate() {
    initializeDateFormatting();
    Intl.defaultLocale = 'pt_BR';
  }

  String formatDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

  String formatDateWek(String date) =>
      date != '' ? DateFormat("EEEE - MMMM").format(dateParse(date)).replaceAll("-feira", "") : '';

  String formatDateString(String date) => date != '' ? DateFormat("dd/MM/yy").format(dateParse(date)) : '';

  String formatDateStringDb(String date) =>
      date != '' ? DateFormat("dd/MM/yyyy").format(dateParse(date)) : '';

  String formatDateStringNotification(DateTime date) => DateFormat('dd/MM/yyyy hh:mm:ss').format(date);

  DateTime dateParse(String date) => DateFormat('dd/MM/yyyy').parse(date);

  DateTime dateParseAlert(String date) => DateFormat('yyyy-MM-dd hh:mm:ss').parse(date);
}
