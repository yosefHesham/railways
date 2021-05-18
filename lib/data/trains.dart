import 'package:railways/model/stations.dart';
import 'package:railways/model/train.dart';

List<Train> trains = [
  Train(number: "921", noStations: 4, noOfSeats: 200, weekDayRuns: {
    "sat": true,
    "san": true,
    "mon": true,
    "tue": false,
    "wed": true,
    "thu": true,
    "fri": false
  }, stopStations: [
    StopStations(
        name: "Cairo",
        order: 17,
        orderInRoute: 1,
        departTime: "18:5:00",
        arrivalTime: "18:00:00",
        stopTime: 5),
    StopStations(
        name: "Tanta",
        order: 9,
        orderInRoute: 2,
        departTime: "19:5:00",
        arrivalTime: "19:00:00",
        stopTime: 5),
    StopStations(
        name: "Sidi Gaber",
        order: 2,
        orderInRoute: 3,
        departTime: "20:35:00",
        arrivalTime: "20:30:00",
        stopTime: 5),
    StopStations(
        name: "Alexandria",
        order: 1,
        orderInRoute: 4,
        departTime: "20:45:00",
        arrivalTime: "20:40:00",
        stopTime: 10),
  ], fareClassess: {
    ClassesOptions.A1: FareClassess(noOfSeats: 60, basePrice: 40),
    ClassesOptions.A2: FareClassess(noOfSeats: 50, basePrice: 30),
    ClassesOptions.A3: FareClassess(noOfSeats: 40, basePrice: 50)
  })
];

mapEnumToString(ClassesOptions options) {
  if (options == ClassesOptions.A1) {
    return "1A";
  } else if (options == ClassesOptions.A2) {
    return "2A";
  }
  return "3A";
}
