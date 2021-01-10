import 'package:intl/intl.dart';

String convertExpireDate(String date) {
  const String firstDay = '01';
  return DateFormat('dd/MM/yyyy').parse(firstDay + '/' + date).toIso8601String();
}

String convertDate(DateTime dateTime) {
  return dateTime.toIso8601String();
}

String convertFromIso8601StringToExpireDate(String date){
  String year = date.substring(0, 4);
  String month = date.substring(5, 7);
  return month + '/' + year;
}

String convertFromIso8601StringToDate(String date) {
  String year = date.substring(0, 4);
  String month = date.substring(5,7);
  String day = date.substring(8, 10);
  return '$day.$month.$year';
}