import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:railways/model/journey.dart';
import 'package:railways/providers/journey_provider.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/screens/booking_screen.dart';

// ignore: must_be_immutable
class BookingDetails extends StatefulWidget {
  Map<String, bool> weekDayRuns;
  String degree;
  BookingDetails(this.weekDayRuns, {this.degree});

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  initState() {
    super.initState();

    /// this function generate dates in range of a week based on weekdayruns
    mapWeekDaysToDates(widget.weekDayRuns);
    checkIfTrainDeparted();
  }

  List<String> dates = [];
  bool isDeparted = false;

  @override
  Widget build(BuildContext context) {
    final selectedTrain =
        Provider.of<TrainsProvider>(context, listen: false).selectedTrain;
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.grey[200]),
        child: FutureBuilder<Journey>(
          future: Provider.of<JourneyProvider>(context, listen: false)
              .fetchJourney(selectedTrain.number),
          builder: (ctx, snapshot) =>
              snapshot.connectionState == ConnectionState.waiting
                  ? JumpingDotsProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      fontSize: 25,
                    )
                  : Column(
                      children: dates
                          .map((e) => buildBookingRow(e, snapshot.data))
                          .toList(),
                    ),
        ));
  }

  Widget buildBookingRow(String date, Journey journey) {
    var from = Provider.of<TrainsProvider>(context, listen: false)
        .fromStationOfSelectedTrain;
    var seats = journey.scheduels
        .firstWhere((element) => element.containsKey(from.name));
    var selectedClass = Provider.of<TrainsProvider>(context, listen: false)
            .selectedClass
            ?.keys
            ?.first ??
        widget.degree;

    int availSeats = seats[from.name][date] == null
        ? 100
        : seats[from.name][date][selectedClass];
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(date),
        ),
        Visibility(
          child: Text(
            availSeats == 0 ? "No available seats" : "Train Departed",
            style: TextStyle(color: Public.accent),
          ),
          visible: isDeparted &&
                      date ==
                          DateFormat('EEE, d MMM')
                              .format(DateTime.now())
                              .toString() ||
                  availSeats == 0
              ? true
              : false,
        ),
        Container(
            width: 100,
            height: 25,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    color: isDeparted &&
                                date ==
                                    DateFormat('EEE, d MMM')
                                        .format(DateTime.now())
                                        .toString() ||
                            availSeats == 0
                        ? Colors.grey
                        : Colors.blue),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: InkWell(
                onTap: isDeparted &&
                            date ==
                                DateFormat('EEE, d MMM')
                                    .format(DateTime.now())
                                    .toString() ||
                        availSeats == 0
                    ? null
                    : () {
                        Navigator.of(context)
                            .pushNamed(BookingScreen.routeName);
                        Provider.of<TrainsProvider>(context, listen: false)
                            .selectBookingDate(date);
                      },
                child: Text(
                  'Book now',
                  style: TextStyle(
                      color: isDeparted &&
                                  date ==
                                      DateFormat('EEE, d MMM')
                                          .format(DateTime.now())
                                          .toString() ||
                              availSeats == 0
                          ? Colors.grey
                          : Colors.blue),
                ),
              ),
            ))
      ]),
      Divider()
    ]);
  }

  void checkIfTrainDeparted() {
    final currentHour = DateTime.now().hour;
    final currentMnts = DateTime.now().minute;
    final trainDeparts = Provider.of<TrainsProvider>(context, listen: false)
        .fromStationOfSelectedTrain
        .departTime
        .split(":");
    final departTimeH = int.parse(trainDeparts[0]);
    final departTimeMnts = int.parse(trainDeparts[1]);

    if (currentHour > departTimeH) {
      setState(() {
        isDeparted = true;
      });
    } else if (currentHour == departTimeH &&
        currentMnts - departTimeMnts > 15) {
      isDeparted = true;
    }
  }

  void mapWeekDaysToDates(Map<String, bool> weekDayRuns) {
    List<String> workingDays = [];
    for (int i = 0; i < 7; i++) {
      String date = DateFormat('EEE, d MMM')
          .format(DateTime.now().add(Duration(days: i)))
          .toString();
      dates.add(date);
    }
    dates.forEach((d) {
      List day = d.split(',');
      if (weekDayRuns[day[0].toLowerCase()]) {
        workingDays.add(d);
      }
    });
    dates = workingDays;
  }
}
