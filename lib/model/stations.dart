class Stations {
  String name;
  int order;
  bool isCapital;
  Stations({this.name, this.order, this.isCapital});
}

class StopStations extends Stations {
  int orderInRoute;
  String arrivalTime;
  String departTime;
  int stopTime;
  Map<String, dynamic> numberOfSeatsPerDay;
  StopStations(
      {String name,
      int order,
      bool isCapital,
      this.orderInRoute,
      this.departTime,
      this.arrivalTime,
      this.numberOfSeatsPerDay,
      this.stopTime})
      : super(name: name, order: order, isCapital: isCapital);

  StopStations.fromMap(Map<String, dynamic> stations) {
    name = stations['name'];
    order = stations['order'] as int;
    orderInRoute = stations['orderInRoute'] as int;
    departTime = stations['departTime'].toString();
    arrivalTime = stations['arrivalTime'].toString();
    stopTime = stations['stopTime'] as int;
  }
}
