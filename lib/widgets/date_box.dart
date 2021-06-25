import 'package:flutter/material.dart';
import 'package:railways/helpers/map_dayruns.dart';

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
  DayBoxRow(this.weekDayRuns);
  final Map<String, bool> weekDayRuns;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: mapDays(weekDayRuns)
            .map((dayData) =>
                DayBox(day: dayData.day, isActive: dayData.isActive))
            .toList());
  }
}
