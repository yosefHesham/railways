import 'package:flutter/material.dart';
import 'package:railways/model/train.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/widgets/timeline_rightChild.dart';
import 'package:railways/widgets/track_line.dart';

// ignore: must_be_immutable
class RunningStatusScreen extends StatefulWidget {
  Train train;
  RunningStatusScreen(this.train);
  @override
  _RunningStatusScreenState createState() => _RunningStatusScreenState();
}

var notDeparted = false;
var isArrived = false;

class _RunningStatusScreenState extends State<RunningStatusScreen> {
  initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      print(DateTime.now().toString());
      String departTime = widget.train.stopStations.first.departTime;
      String arrivalTime = widget.train.stopStations.last.arrivalTime;
      if (DateTime.now().hour < int.parse(departTime.substring(0, 2)) ||
          (DateTime.now().hour == int.parse(departTime.substring(0, 2)) &&
              DateTime.now().minute < int.parse(departTime.substring(3, 5)))) {
        setState(() {
          notDeparted = true;
        });
      } else if (DateTime.now().hour > int.parse(arrivalTime.substring(0, 2)) ||
          (DateTime.now().hour == int.parse(arrivalTime.substring(0, 2)) &&
              DateTime.now().minute > int.parse(arrivalTime.substring(3, 5)))) {
        setState(() {
          isArrived = true;
        });
        print("isArrived $isArrived");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Container(
            color: Theme.of(context).primaryColor,
            child: ListTile(
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.arrow_back,
                    color: Public.textFieldColor,
                  ),
                ),
                subtitle: Text(
                    notDeparted
                        ? "Not Departed"
                        : isArrived
                            ? "Train Arrived Destination"
                            : "Train Running",
                    style: TextStyle(
                        fontSize: 18,
                        color: Public.textFieldFillColor,
                        fontWeight: FontWeight.w500)),
                title: Text(
                  widget.train.number,
                  style: TextStyle(
                      color: Public.textFieldColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 22),
                )),
          )),
      body: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 20),
          child: ListView.builder(
              itemCount: widget.train.stopStations.length,
              itemBuilder: (ctx, i) =>
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    TrackLine(
                      radius:
                          i == widget.train.stopStations.length - 1 ? 5 : 0.0,
                      firstStaion: i == widget.train.stopStations.length - 1
                          ? widget.train.stopStations[i - 1]
                          : widget.train.stopStations[i],
                      secondStaion: i == widget.train.stopStations.length - 1
                          ? widget.train.stopStations.last
                          : widget.train.stopStations[i + 1],
                    ),
                    TimeLineRChild(widget.train.stopStations[i])
                  ]))),
    ));
  }
}
