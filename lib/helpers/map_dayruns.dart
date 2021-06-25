import 'package:flutter/material.dart';

List<DayRuns> mapDays(Map<String, bool> weekDayRuns) {
  List<DayRuns> dayRuns = [];
  dayRuns = weekDayRuns.entries
      .map((e) => DayRuns(day: e.key.toUpperCase(), isActive: e.value))
      .toList();
  return dayRuns;
}

// List<DayRuns> days = [
//   DayRuns(day: "S", isActive: true),
//   DayRuns(day: "S", isActive: true),
//   DayRuns(day: "M", isActive: false),
//   DayRuns(day: "T", isActive: true),
//   DayRuns(day: "W", isActive: false),
//   DayRuns(day: "T", isActive: true),
//   DayRuns(day: "F", isActive: false)
// ];

class DayRuns {
  String day;
  bool isActive;
  DayRuns({@required this.day, @required this.isActive});
}
