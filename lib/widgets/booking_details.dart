import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/screens/booking_screen.dart';

// ignore: must_be_immutable
class BookingDetails extends StatefulWidget {
  Map<String, bool> weekDayRuns;
  BookingDetails(this.weekDayRuns);

  @override
  _BookingDetailsState createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  initState() {
    super.initState();

    /// this function generate dates in range of a week based on weekdayruns
    mapWeekDaysToDates(widget.weekDayRuns);
  }

  List<String> dates = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Colors.grey[200]),
      child: Column(
        children: dates.map((e) => buildBookingRow(e)).toList(),
      ),
    );
  }

  Widget buildBookingRow(String date) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(date),
        ),
        Container(
            width: 100,
            height: 25,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(BookingScreen.routeName);
                  Provider.of<TrainsProvider>(context, listen: false)
                      .selectBookingDate(date);
                },
                child: Text(
                  'Book now',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ))
      ]),
      Divider()
    ]);
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
