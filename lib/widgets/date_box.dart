import 'package:flutter/material.dart';

class DayBox extends StatelessWidget {
  final String day;
  final bool isActive;
  DayBox({@required this.day, @required this.isActive});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        border: Border.all(
          color: isActive ? Colors.green.shade300 : Colors.grey,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          day,
          style:
              TextStyle(color: isActive ? Colors.green.shade300 : Colors.grey),
        ),
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
