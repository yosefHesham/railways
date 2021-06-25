import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/widgets/booking_details.dart';
import 'package:railways/widgets/train_card.dart';

class SearchResultScreen extends StatelessWidget {
  static const routeName = '/serachResult';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<TrainsProvider>(
            builder: (ctx, trainProv, _) => ListView.builder(
                itemCount: trainProv.trains.length,
                itemBuilder: (ctx, i) => Column(children: [
                      TrainCard(trainProv.trains[i]),
                      trainProv.selectedTrain == trainProv.trains[i]
                          ? Visibility(
                              child: BookingDetails(
                                  trainProv.trains[i].weekDayRuns),
                              visible: trainProv.isBookingVisible,
                            )
                          : Container()
                    ]))));
  }
}
