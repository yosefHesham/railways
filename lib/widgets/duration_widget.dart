import 'package:flutter/material.dart';

import 'distance_line.dart';

// ignore: must_be_immutable
class TripDuration extends StatefulWidget {
  final String fromTime, toTime;
  final String date;
  String numOfStops;
  TripDuration(
      {@required this.fromTime,
      @required this.toTime,
      this.date,
      this.numOfStops});

  @override
  _TripDurationState createState() => _TripDurationState();
}

class _TripDurationState extends State<TripDuration> {
  List<int> duration = [];
  @override
  void initState() {
    super.initState();
    getDuration();
  }

  getDuration() {
    List<String> fromStString = widget.fromTime.split(':');
    List<int> fromTime = fromStString.map((e) => int.parse(e)).toList();
    List<String> toStString = widget.toTime.split(':');
    List<int> toTime = toStString.map((e) => int.parse(e)).toList();

    setState(() {
      duration.add(
        toTime[0] - fromTime[0],
      );
      duration.add(toTime[1] - fromTime[1]);
    });
  }

  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        stopTime(widget.date, widget.fromTime),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Text(
              '${duration[0] % 12}h ${(duration[1].abs())}m',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            DistanceLine(),
            Text(
              "${widget.numOfStops} stops",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            )
          ],
        ),
        SizedBox(
          width: 20,
        ),
        stopTime(widget.date, widget.toTime),
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
