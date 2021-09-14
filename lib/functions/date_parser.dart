import 'package:intl/intl.dart';

class DateParser {
  static List<String> dayNames = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu"
  ];
  static List<String> monthNames = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];

  static String parse(DateTime dateTime) {
    var localDate = dateTime.toLocal();
    var dayName = dayNames[localDate.weekday - 1];
    var monthName = monthNames[localDate.month - 1];
    var formatter = NumberFormat("00");
    return "$dayName, ${localDate.day} $monthName ${localDate.year}, Pk. ${formatter.format(localDate.hour)}:${formatter.format(localDate.minute)}";
  }

  static String parseDate(DateTime dateTime) {
    var localDate = dateTime.toLocal();
    // var dayName = dayNames[localDate.weekday - 1];
    var monthName = monthNames[localDate.month - 1];
    // return "$dayName, ${localDate.day} $monthName ${localDate.year}";
    return "${localDate.day} $monthName ${localDate.year}";
  }

  static String parseTime(DateTime dateTime) {
    var localDate = dateTime.toLocal();
    var formatter = NumberFormat("00");
    return "Pk. ${formatter.format(localDate.hour)}:${formatter.format(localDate.minute)}";
  }
}
