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
    Map<String, FareClassess> classes = {};
    Map<String, bool> dayRuns = {};
    (trains['fareClassess'] as Map<String, dynamic>).forEach((key, value) {
      classes[key] = FareClassess.fromMap(trains['fareClassess'][key]);
    });
    (trains['weekDayRuns'] as Map<String, dynamic>).forEach((key, value) {
      dayRuns[key] = value;
    });

    number = trains['number'].toString();
    noOfSeats = trains['noOfSeats'] as int;
    noOfStations = trains['noOfStations'] as int;
    weekDayRuns = dayRuns;
    fareClassess = classes;

    stopStations = (trains['stopStation'] as List<dynamic>)
        .map((e) => StopStations.fromMap(e))
        .toList();
  }
}

class FareClassess {
  num noOfSeats;
  num basePrice;
  FareClassess({@required this.noOfSeats, this.basePrice});
  FareClassess.fromMap(Map<String, dynamic> fareClass) {
    noOfSeats = fareClass['noOfSeats'];
    basePrice = fareClass['basePrice'];
  }
}

// enum ClassesOptions { A1, A2, A3 }
