import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/providers/trains_provider.dart';
import 'package:railways/public/colors.dart';
import 'package:railways/widgets/booking_details.dart';
import 'package:railways/widgets/train_card.dart';

class SearchResultScreen extends StatelessWidget {
  static const routeName = '/serachResult';
  @override
  Widget build(BuildContext context) {
    final from =
        Provider.of<TrainsProvider>(context, listen: false).fromStation;
    final to = Provider.of<TrainsProvider>(context, listen: false).toStation;
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
                  title: Text(
                    "$from ~ $to",
                    style: TextStyle(
                        color: Public.textFieldFillColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
                )),
          ),
          body: Consumer<TrainsProvider>(
              builder: (ctx, trainProv, _) =>
                  trainProv.trains.isEmpty || trainProv.trains == null
                      ? Center(
                          child: Text("No Available trains !"),
                        )
                      : ListView.builder(
                          itemCount: trainProv.trains.length,
                          itemBuilder: (ctx, i) => Column(children: [
                                TrainCard(trainProv.trains[i]),
                                trainProv.selectedTrain == trainProv.trains[i]
                                    ? Visibility(
                                        visible: trainProv.isBookingVisible,
                                        child: BookingDetails(
                                          trainProv.trains[i].weekDayRuns,
                                        ),
                                      )
                                    : Container()
                              ])))),
    );
  }
}
