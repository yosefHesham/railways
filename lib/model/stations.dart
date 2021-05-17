import 'package:flutter/foundation.dart';

class Stations {
  String name;
  int order;
  bool isCapital;
  Stations(
      {@required this.name, @required this.order, @required this.isCapital});
}

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
