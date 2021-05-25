import 'package:flutter/material.dart';
import 'package:railways/widgets/date_box.dart';
import 'package:railways/widgets/degree_box.dart';
import 'package:railways/widgets/duration_widget.dart';

class SearchResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                trainNumber(),
                SizedBox(
                  width: 60,
                ),
                DayBoxRow(),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TripDuration(),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                DegreeBox(degree: '1A', price: 105),
                DegreeBox(degree: '2A', price: 80),
                DegreeBox(degree: '3A', price: 50)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget trainNumber() {
    return InkWell(
        onTap: () => print("x"),
        child: Row(children: [
          Text(
            '02461',
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
