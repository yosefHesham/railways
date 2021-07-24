import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/model/train.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/screens/train_details.dart';
import 'package:railways/widgets/date_box.dart';
import 'package:railways/widgets/degree_box.dart';
import 'package:railways/widgets/duration_widget.dart';

// ignore: must_be_immutable
class TrainCard extends StatefulWidget {
  final Train train;
  TrainCard(this.train);

  @override
  _TrainCardState createState() => _TrainCardState();
}

class _TrainCardState extends State<TrainCard> {
  bool isVisible = false;
  var currentIndex;

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildTrainCard(context);
  }

  Card buildTrainCard(BuildContext context) {
    final degreesList = widget.train.fareClassess.entries.toList();
    degreesList.sort((a, b) => b.value.basePrice.compareTo(a.value.basePrice));
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                trainNumber(widget.train.number, context),
                SizedBox(
                  width: 60,
                ),
                DayBoxRow(widget.train.weekDayRuns),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Consumer<TrainsProvider>(
              builder: (context, trainProv, _) {
                final stations = widget.train.stopStations;

                final fromStation = stations
                    .where((st) => st.name == trainProv.fromStation)
                    .first;
                final toStation = stations
                    .where((st) => st.name == trainProv.toStation)
                    .first;
                return TripDuration(
                    fromTime: fromStation.departTime,
                    toTime: toStation.departTime,
                    date: trainProv.date,
                    numOfStops:
                        (toStation.orderInRoute - fromStation.orderInRoute)
                            .toString());
              },
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: MediaQuery.of(context).size.height * .1,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: degreesList.length,
                  itemBuilder: (ctx, i) => DegreeBox(
                        degree: degreesList[i].key,
                        price: degreesList[i].value.basePrice,
                        index: i,
                        changeIndex: changeIndex,
                        borderColor: currentIndex == null || currentIndex != i
                            ? Public.accent
                            : Public.textFieldFillColor,
                        trainNum: widget.train.number,
                      )),
            ),
          ],
        ),
      ),
    );
  }

  Widget trainNumber(String number, BuildContext context) {
    return InkWell(
        onTap: () {
          Provider.of<TrainsProvider>(context, listen: false)
              .selectTrain(number);
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => TrainDetailScreen(widget.train)));
        },
        child: Row(children: [
          Text(
            number,
            style: TextStyle(color: Colors.blue.shade900, fontSize: 18),
          ),
          Icon(
            Icons.arrow_forward_ios_outlined,
            color: Colors.blue.shade900,
            size: 18,
          )
        ]));
  }
}
