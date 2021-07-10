import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/model/train.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/screens/train_details.dart';
import 'package:railways/widgets/date_box.dart';
import 'package:railways/widgets/degree_box.dart';
import 'package:railways/widgets/duration_widget.dart';

// ignore: must_be_immutable
class TrainCard extends StatelessWidget {
  final Train train;
  TrainCard(this.train);
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return buildTrainCard(context);
  }

  Card buildTrainCard(BuildContext context) {
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
                trainNumber(train.number, context),
                SizedBox(
                  width: 60,
                ),
                DayBoxRow(train.weekDayRuns),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Consumer<TrainsProvider>(
              builder: (context, trainProv, _) {
                final stations = train.stopStations;

                final fromStation = stations
                    .where((st) => st.name == trainProv.fromStation)
                    .first;
                final toStation = stations
                    .where((st) => st.name == trainProv.toStation)
                    .first;
                return TripDuration(
                  fromStation: fromStation,
                  toStation: toStation,
                  date: trainProv.date,
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
                children: train.fareClassess.entries
                    .map((e) => DegreeBox(
                          degree: e.key,
                          price: e.value.basePrice,
                          trainNum: train.number,
                        ))
                    .toList())
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
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => TrainDetailScreen(train)));
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
