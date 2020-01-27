import 'package:intl/intl.dart';

String formatDate(DateTime dateTime) {
  var formatter = DateFormat("y-MM-dd");
  String formattedDate = formatter.format(dateTime);

  return formattedDate;
}

int nowTimeStamp() {
  return DateTime.now().millisecondsSinceEpoch;
}
