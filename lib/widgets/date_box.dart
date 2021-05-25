import 'package:flutter/material.dart';

class DayBox extends StatelessWidget {
  final String day;
  final bool isActive;
  DayBox({@required this.day, @required this.isActive});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        day,
        style: TextStyle(
            color: isActive ? Colors.green.shade300 : Colors.grey,
            fontSize: 12),
      ),
    );
  }
}

class DayBoxRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: days
            .map((dayData) =>
                DayBox(day: dayData.day, isActive: dayData.isActive))
            .toList());
  }
}

List<DayRuns> days = [
  DayRuns(day: "S", isActive: true),
  DayRuns(day: "S", isActive: true),
  DayRuns(day: "M", isActive: false),
  DayRuns(day: "T", isActive: true),
  DayRuns(day: "W", isActive: false),
  DayRuns(day: "T", isActive: true),
  DayRuns(day: "F", isActive: false)
];

class DayRuns {
  String day;
  bool isActive;
  DayRuns({@required this.day, @required this.isActive});
}
