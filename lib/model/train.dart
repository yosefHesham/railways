import 'package:flutter/foundation.dart';
import 'package:railways/model/stations.dart';

class Train {
  String number;
  List<StopStations> stopStations;
  int noOfStations;
  Map<String, bool> weekDayRuns;
  int noOfSeats;
  Map<String, FareClassess> fareClassess;
  Train(
      {@required this.number,
      @required this.stopStations,
      @required this.noOfSeats,
      @required this.fareClassess,
      @required this.noOfStations,
      @required this.weekDayRuns});

  Train.fromMap(Map<String, dynamic> trains) {
    number = trains['number'];
    noOfSeats = trains['noOfSeats'];
    noOfStations = trains['noOfStations'];
    weekDayRuns = trains['weekDayRuns'];
    fareClassess = trains['fareClasses'];
    stopStations = (trains['stopStation'] as List<Map<String, dynamic>>)
        .map((e) => StopStations.fromMap(e))
        .toList();
  }
}

class FareClassess {
  int noOfSeats;
  num basePrice;
  FareClassess({@required this.noOfSeats, this.basePrice});

  FareClassess.fromMap(Map<String, dynamic> classes) {
    noOfSeats = classes['noOfSeats'];
    basePrice = classes['basePrice'];
  }
}

// enum ClassesOptions { A1, A2, A3 }
