import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:railways/model/stations.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/widgets/timeline_rightChild.dart';

// ignore: must_be_immutable
class TrackLine extends StatefulWidget {
  StopStations firstStaion;
  StopStations secondStaion;
  bool notDeparted;
  bool isArrived;
  double radius;
  TrackLine({
    @required this.firstStaion,
    @required this.secondStaion,
    @required this.isArrived,
    @required this.notDeparted,
    this.radius,
  });

  @override
  _TrackLineState createState() => _TrackLineState();
}

class _TrackLineState extends State<TrackLine> {
  var fractionFactor = .001;
  var fractionTime = 0.0;
  @override
  initState() {
    print("init state trackline ${widget.isArrived}");
    super.initState();
    // if (widget.isArrived) {
    //   setState(() {
    //     print("not departed");
    //     fractionTime = 1;
    //   });
    //   return;
    // } else if (widget.notDeparted) {
    //   setState(() {
    //     fractionTime = 0;
    //   });
    //   return;
    // }

    estimateTime();
  }

  void estimateTime() {
    Future.delayed(Duration.zero).then((_) {
      print(
          " firstStation: ${widget.firstStaion.name}${widget.firstStaion.departTime}");
      print(
          " firstStation: ${widget.secondStaion.name}${widget.secondStaion.arrivalTime}");
      var arrivalTimeString = widget.secondStaion.arrivalTime;
      var arrivalTime = (int.parse(arrivalTimeString.substring(0, 2)) * 60) +
          int.parse(arrivalTimeString.substring(3, 5));
      var departTimeString = widget.firstStaion.departTime;
      var departTime = (int.parse(departTimeString.substring(0, 2)) * 60) +
          int.parse(departTimeString.substring(3, 5));
      var totalDuration = arrivalTime - departTime;
      print("nowTime ${TimeOfDay.now().hour} + ${TimeOfDay.now().minute}");
      var nowTime = (DateTime.now().hour * 60) + DateTime.now().minute;
      var elapsedTime = nowTime - departTime;
      print("totalDuration $totalDuration");
      print("elapsedTime ${elapsedTime}");
      if (elapsedTime >= 0) {
        setState(() {
          fractionTime = elapsedTime / totalDuration;
          print(fractionTime);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("trackline");
    return Container(
        margin: const EdgeInsets.only(
          left: 50,
        ),
        width: 15,
        height: MediaQuery.of(context).size.height * .1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.radius),
          color: Colors.grey[200],
        ),
        child: Stack(children: [
          FractionallySizedBox(
              heightFactor: fractionTime > 1
                  ? 1
                  : fractionTime < 0
                      ? 0.0
                      : fractionTime,
              child: Container(
                alignment: Alignment.bottomCenter,
                color: Color(0xff2043B0),
              )),
          Container(
            width: 10,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius)),
            child: Column(
              children: [widget.firstStaion]
                  .map((e) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      child: Stack(children: [
                        Icon(
                          Icons.brightness_1,
                          size: 10,
                          color: Public.textFieldColor,
                        ),
                      ])))
                  .toList(),
            ),
          ),
        ]));
  }

  // double getFraction() {
  //   var timeOfDay =
  //       (TimeOfDay.now().hour == 00 ? 12 : TimeOfDay.now().hour * 60) +
  //           TimeOfDay.now().minute;
  //   var lastStation = widget.stations.last.arrivalTime;
  //   var arrivalTime = (int.parse(lastStation.substring(0, 2)) * 60) +
  //       int.parse(lastStation.substring(3, 5));
  //   print(TimeOfDay.now());
  //   print(timeOfDay);
  //   print(arrivalTime);
  //   print(lastStation);
  //   print(timeOfDay / arrivalTime);
  //   print(timeOfDay / arrivalTime);
  //   return timeOfDay / arrivalTime;
  // }
}
