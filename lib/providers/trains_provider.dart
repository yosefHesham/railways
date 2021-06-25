import 'package:flutter/foundation.dart';
import 'package:railways/model/stations.dart';
import 'package:railways/model/train.dart';
import 'package:railways/providers/repos/train_repo.dart';
import 'package:railways/helpers/day_extractor.dart';

class TrainsProvider with ChangeNotifier {
  BaseTrainRepo _trainRepo = TrainRepo();
  List<Train> _trains = [];
  String _fromStation;
  String _toStation;
  String _date;
  bool _isBookingVisible = false;
  Train _selectedTrain;

  bool get isBookingVisible {
    return _isBookingVisible;
  }

  Train get selectedTrain {
    return _selectedTrain;
  }

  List<Train> get trains {
    return _trains;
  }

  String get fromStation {
    return _fromStation;
  }

  String get toStation {
    return _toStation;
  }

  String get date {
    return _date;
  }

  Future<void> getTrains() async {
    _trains = await _trainRepo.getTrains();
  }

  void showBookingOptions(String trainNum) {
    print("number: $trainNum");
    _selectedTrain =
        _trains.firstWhere((element) => element.number == trainNum);
    if (_selectedTrain.number == trainNum) {
      _isBookingVisible = true;
    }
    notifyListeners();
  }

  void fromTo(String from, String to, String date) {
    print("date:: ${date.extractDay()}");
    _fromStation = from;
    _toStation = to;
    _date = date;
    StopStations fromStation;
    StopStations toStation;

    _trains = _trains.where((train) {
      print("trainNo: ${train.number}");
      print("wedensday: ${train.weekDayRuns[date.extractDay()]}");
      if (train.weekDayRuns[date.extractDay()]) {
        train.stopStations.forEach((station) {
          if (station.name.toLowerCase() == from.toLowerCase()) {
            fromStation = station;
          }
          if (station.name.toLowerCase() == to.toLowerCase()) {
            toStation = station;
          }
        });
        if (toStation != null && fromStation != null) {
          if (toStation.orderInRoute < fromStation.orderInRoute) {
            return false;
          }
        }
        return true;
      }
      return false;
    }).toList();
    notifyListeners();
  }
}
