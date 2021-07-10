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
  String _bookDate;
  bool _isBookingVisible = false;
  Train _selectedTrain;
  Map<String, dynamic> _selectedClass;

  bool get isBookingVisible {
    return _isBookingVisible;
  }

  Map<String, dynamic> get selectedClass {
    return _selectedClass;
  }

  Train get selectedTrain {
    print("selectedTrain :$_selectedTrain");
    return _selectedTrain;
  }

  String get bookDate {
    return _bookDate;
  }

  StopStations get fromStationOfSelectedTrain {
    return _selectedTrain.stopStations
        .firstWhere((element) => element.name == fromStation);
  }

  StopStations get toStationOfSelectedTrain {
    return _selectedTrain.stopStations
        .firstWhere((element) => element.name == toStation);
  }

  List<Train> get trains {
    return [..._trains];
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

  void selectTrain(String trainNum) {
    _selectedTrain =
        _trains.firstWhere((element) => element.number == trainNum);
    notifyListeners();
  }

  void showBookingOptions(String trainNum) {
    _selectedTrain =
        _trains.firstWhere((element) => element.number == trainNum);
    if (_selectedTrain.number == trainNum) {
      _isBookingVisible = true;
    }
  }

  void selectBookingDate(String date) {
    _bookDate = date;
    notifyListeners();
  }

  void selectClass(Map<String, int> degree) {
    _selectedClass = degree;
    notifyListeners();
  }

  void fromTo(String from, String to, String date) {
    _fromStation = from;
    _toStation = to;
    _date = date;

    _trains = _trains.where((train) {
      StopStations fromStation;
      StopStations toStation;

      if (train.weekDayRuns[date.extractDay()]) {
        train.stopStations.forEach((station) {
          if (station.name.toLowerCase() == from.toLowerCase()) {
            fromStation = station;
          } else if (station.name.toLowerCase() == to.toLowerCase()) {
            toStation = station;
          }
        });
        if (toStation != null && fromStation != null) {
          if (toStation.orderInRoute < fromStation.orderInRoute) {
            return false;
          }
          return true;
        }
        return false;
      }
      return false;
    }).toList();
    notifyListeners();
  }
}
