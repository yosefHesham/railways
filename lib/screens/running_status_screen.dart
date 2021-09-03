import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:railways/model/train.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/widgets/timeline_rightChild.dart';
import 'package:railways/widgets/track_line.dart';

// ignore: must_be_immutable
class RunningStatusScreen extends StatefulWidget {
  Train train;
  DateTime chosenDate;

  RunningStatusScreen(this.train, this.chosenDate);
  @override
  _RunningStatusScreenState createState() => _RunningStatusScreenState();
}

String trainStatus = "";

class _RunningStatusScreenState extends State<RunningStatusScreen> {
  initState() {
    super.initState();
    String now = DateFormat('EEE, d MMM')
        .format(DateTime.now())
        .split(",")[0]
        .toLowerCase();
    Train train =
        Provider.of<TrainsProvider>(context, listen: false).selectedTrain;
    if (!train.weekDayRuns[now]) {
      setState(() {
        trainStatus = "OFF Day";
      });
    } else if (widget.chosenDate.isAfter(DateTime.now())) {
      setState(() {
        trainStatus = "Train Arrived Destination";
      });
    } else {
      Future.delayed(Duration.zero).then((_) {
        Train train;
        train =
            Provider.of<TrainsProvider>(context, listen: false).selectedTrain;
        String departTime = train.stopStations.first.departTime;
        String arrivalTime = train.stopStations.last.arrivalTime;

        List<String> now =
            DateFormat("HH:mm:ss").format(DateTime.now()).split(":");
        print(now);
        if (int.parse(now[0]) < int.parse(departTime.substring(0, 2)) ||
            (int.parse(now[0]) == int.parse(departTime.substring(0, 2)) &&
                int.parse(now[1]) < int.parse(departTime.substring(3, 5)))) {
          setState(() {
            trainStatus = "Not Departed";
          });
        } else if (int.parse(now[0]) > int.parse(arrivalTime.substring(0, 2)) ||
            (int.parse(now[0]) == int.parse(arrivalTime.substring(0, 2)) &&
                int.parse(now[1]) > int.parse(arrivalTime.substring(3, 5)))) {
          print(widget.train.stopStations.last.name);
          setState(() {
            trainStatus = "Train Arrived Destination";
          });
        }
      });
    }
  }

  dispose() {
    print("Disposeed");
    super.dispose();
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
                  onPressed: () {
                    Navigator.of(context).pop();
                    dispose();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Public.textFieldColor,
                  ),
                ),
                subtitle: Text(trainStatus,
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
                      choseDate: widget.chosenDate,
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
