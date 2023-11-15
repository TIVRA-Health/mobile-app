import 'package:intl/intl.dart';

class DateFormats {
  static String yMdHmsZFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
  static String dMyFormat = 'dd-MM-yyyy';
  static String yMdFormat = 'yyyy-MM-dd';
  static String mDYFormat = 'MM-dd-yyyy';

}

/// Get local date from system
DateTime getCurrentDate() {
  final currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  return DateFormat('yyyy-MM-dd').parse(currentDate).toLocal();
}

String? getDateFromDate(String? from,
    {required String fromDateFormat, required String toDateString}) {
  if (from == null) {
    return "";
  }

  DateTime parseDate = DateFormat(fromDateFormat).parse(from);
  var inputDate = DateTime.parse(parseDate.toString());
  var outputFormat = DateFormat(toDateString);
  var outputDate = outputFormat.format(inputDate);
  return outputDate;
}

 String getDate (String date) {
  if(date.isNotEmpty) {
    print("##date##$date");
    DateTime dateTime = DateTime.parse(date);
    print("#######${dateTime.day}");
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    print("##date##$formattedDate");
    return formattedDate;
  }
  return "__";
}


