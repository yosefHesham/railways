import 'package:railways/data/months.dart';

extension DayExtractor on String {
  String extractDay() {
    List dateSplitted = this.split(',');

    return dateSplitted[0].toString().toLowerCase();
  }
}

extension AnalysisFormat on String {
  String analysisFormat() {
    
    List<String> dateList = this.split(",");
    dateList = dateList[1].split(" ");
    int year = DateTime.now().year;
    String monthDay = months[dateList[2]];
    String monthFormat = monthDay.length == 1 ? "0$monthDay" : monthDay;
    String dayFormat =
        dateList[1].length == 1 ? "0${dateList[1]}" : dateList[1];
    String dateFormatted = "$dayFormat-$monthFormat-$year";
    return dateFormatted;
  }
}
