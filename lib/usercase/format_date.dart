import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class FormatDate {
  FormatDate() {
    initializeDateFormatting();
    Intl.defaultLocale = 'pt_BR';
  }

  DateTime newDate() => DateTime.now();

  String formatDate(DateTime date) => DateFormat('dd/MM/yyyy').format(date);

  String formatTime(DateTime date) => DateFormat('hh:mm').format(date);

  String formatDateWek(String date) =>
      date != '' ? DateFormat("EEEE - MMMM").format(dateParse(date)).replaceAll("-feira", "") : '';

  String formatDateString(String date) => date != '' ? DateFormat("dd/MM/yy").format(dateParse(date)) : '';

  String formatTimeString(String time) => time != '' ? DateFormat("hh:mm").format(timeParse(time)) : '';

  String formatDateStringDb(String date) =>
      date != '' ? DateFormat("dd/MM/yyyy").format(dateParse(date)) : '';

  String formatDateStringNotification(DateTime date) => DateFormat('dd/MM/yyyy hh:mm:ss').format(date);

  String formatTimeByString(DateTime date) => DateFormat('hh:mm').format(date);

  DateTime dateParse(String date) => DateFormat('dd/MM/yyyy').parse(date);

  DateTime timeParse(String date) => DateFormat('hh:mm').parse(date);

  DateTime dateParseAlert(String date) => DateFormat('yyyy-MM-dd hh:mm:ss').parse(date);
}
