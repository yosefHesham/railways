import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:railways/model/stations.dart';
import 'package:railways/providers/trains_provider.dart';

class TimeLineRChild extends StatelessWidget {
  final StopStations station;
  TimeLineRChild(this.station);

  @override
  Widget build(BuildContext context) {
    final source =
        Provider.of<TrainsProvider>(context, listen: false).fromStation;
    final dest = Provider.of<TrainsProvider>(context, listen: false).toStation;
    return Card(
      margin: const EdgeInsets.only(bottom: 30, left: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                station.name,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: 20,
              ),
              Visibility(
                  visible: station.name == source || station.name == dest
                      ? true
                      : false,
                  child: Text(
                    station.name == source ? "~ Source" : "~ Destination,",
                    style: TextStyle(color: Colors.greenAccent, fontSize: 15),
                  )),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                'Arr: ${station.arrivalTime.substring(0, 5)}',
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15),
              ),
              SizedBox(
                width: 20,
              ),
              Text('Dep: ${station.departTime.substring(0, 5)}',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 15))
            ],
          ),
        ],
      ),
    );
  }
}
