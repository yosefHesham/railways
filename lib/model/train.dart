import 'package:flutter/foundation.dart';
import 'package:railways/model/stations.dart';

class Train {
  String number;
  List<StopStations> stopStations;
  int noStations;
  Map<String, bool> weekDayRuns;
  int noOfSeats;
  Map<ClassesOptions, FareClassess> fareClassess;
  Train(
      {@required this.number,
      @required this.stopStations,
      @required this.noOfSeats,
      @required this.fareClassess,
      @required this.noStations,
      @required this.weekDayRuns});
}

class FareClassess {
  int noOfSeats;
  num basePrice;
  FareClassess({@required this.noOfSeats, this.basePrice});
}

enum ClassesOptions { A1, A2, A3 }

class StopStations extends Stations {
  int orderInRoute;
  String arrivalTime;
  String departTime;
  int stopTime;
  StopStations(
      {@required String name,
      @required int order,
      bool isCapital,
      @required this.orderInRoute,
      @required this.departTime,
      @required this.arrivalTime,
      @required this.stopTime})
      : super(name: name, order: order, isCapital: isCapital);
}
