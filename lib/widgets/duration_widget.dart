import 'package:flutter/material.dart';

import 'distance_line.dart';

class TripDuration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        stopTime("02 May, Sun", "10:27 PM"),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Text(
              '0h13m',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            DistanceLine(),
            Text(
              '2 stops',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            )
          ],
        ),
        SizedBox(
          width: 20,
        ),
        stopTime("02 May, Sun", "10:40 PM"),
      ],
    );
  }
}

stopTime(String date, String time) {
  return Column(
    children: [
      Text(
        time,
        style: TextStyle(
            color: Colors.blue.shade900,
            fontWeight: FontWeight.bold,
            fontSize: 16),
      ),
      Text(
        date,
        style: TextStyle(
            color: Colors.blue.shade100,
            fontSize: 10,
            fontWeight: FontWeight.normal),
      )
    ],
  );
}
