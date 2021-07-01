import 'package:flutter/material.dart';
import 'package:railways/model/stations.dart';

import 'distance_line.dart';

class TripDuration extends StatefulWidget {
  final StopStations fromStation, toStation;
  final String date;
  TripDuration(
      {@required this.fromStation, @required this.toStation, this.date});

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
    List<String> fromStString = widget.fromStation.departTime.split(':');
    List<int> fromTime = fromStString.map((e) => int.parse(e)).toList();
    List<String> toStString = widget.toStation.arrivalTime.split(':');
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
        stopTime(widget.date, widget.fromStation.departTime),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            Text(
              '${duration[0] % 24}h ${(duration[1].abs())}m',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            DistanceLine(),
            Text(
              '${widget.toStation.orderInRoute - widget.fromStation.orderInRoute}',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            )
          ],
        ),
        SizedBox(
          width: 20,
        ),
        stopTime(widget.date, widget.toStation.arrivalTime),
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
