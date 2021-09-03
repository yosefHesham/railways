import 'package:flutter/foundation.dart';
import 'package:railways/helpers/filters.dart';
import 'package:railways/model/stations.dart';
import 'package:railways/model/train.dart';
import 'package:railways/providers/repos/train_repo.dart';
import 'package:railways/helpers/day_extractor.dart';
import 'package:collection/collection.dart';

class TrainsProvider with ChangeNotifier {
  BaseTrainRepo _trainRepo = TrainRepo();
  List<Train> _trains = [];
  String _fromStation;
  String _toStation;
  String _date;
  String _bookDate;
  bool _isBookingVisible = false;
  Train _selectedTrain;
  DateTime _chosenDate;
  Map<String, dynamic> _selectedClass;
  List<Train> _resultTrains = [];
  List<Train> _tempTrains = [];

  bool get isBookingVisible {
    return _isBookingVisible;
  }

  DateTime get chosenDate {
    return _chosenDate ?? DateTime.now();
  }

  Map<String, dynamic> get selectedClass {
    return _selectedClass;
  }

  Train get selectedTrain {
    return _selectedTrain;
  }

  void chooseDate(DateTime date) {
    _chosenDate = date;

    notifyListeners();
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
    return [..._resultTrains];
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

  void sortTrains(String sortType) {
    if (sortType == "Departure") {
      _resultTrains.sort((a, b) =>
          int.parse(a.stopStations.first.departTime.split(":")[0]).compareTo(
              int.parse(b.stopStations.first.departTime.split(":")[0])));
    } else if (sortType == "Arrival") {
      _resultTrains.sort((a, b) =>
          int.parse(a.stopStations.last.arrivalTime.split(":")[0]).compareTo(
              int.parse(b.stopStations.last.arrivalTime.split(":")[0])));
    }
    notifyListeners();
  }

  void filterTrains() {
    _resultTrains = [..._tempTrains];
    List<bool> filterValues = departAt.values.toList();
    Function eq = const ListEquality().equals;
    List<int> earlyMorning = [00, 6];
    List<int> morning = [6, 12];
    List<int> afternoon = [12, 18];
    List<int> night = [18, 00];

    if (!departAt.containsValue(false)) {
      _resultTrains = [..._tempTrains];
    } else if (!departAt.containsValue(true)) {
      _resultTrains = [..._tempTrains];
    } else if (eq(filterValues, [true, false, false, false])) {
      _filter(earlyMorning[0], earlyMorning[1]);
    } else if (eq(filterValues, [false, true, false, false])) {
      _filter(morning[0], morning[1]);
    } else if (eq(filterValues, [false, false, false, true])) {
      _filter(night[0], night[1]);
    } else if (eq(filterValues, [false, false, true, false])) {
      _filter(afternoon[0], afternoon[1]);
    } else if (eq(filterValues, [true, true, false, false])) {
      _twoFilters(earlyMorning[0], earlyMorning[1], morning[0], morning[1]);
    } else if (eq(filterValues, [true, false, true, false])) {
      _twoFilters(earlyMorning[0], earlyMorning[1], afternoon[0], afternoon[1]);
    } else if (eq(filterValues, [true, false, false, true])) {
      _twoFilters(earlyMorning[0], earlyMorning[1], night[0], night[1]);
    } else if (eq(filterValues, [false, true, true, false])) {
      _twoFilters(morning[0], morning[1], afternoon[0], afternoon[1]);
    } else if (eq(filterValues, [false, true, false, true])) {
      _twoFilters(morning[0], morning[1], night[0], night[1]);
    } else if (eq(filterValues, [false, false, true, true])) {
      _twoFilters(afternoon[0], afternoon[1], night[0], night[1]);
    }

    notifyListeners();
  }

  void _filter(int start, int end) {
    _resultTrains = _resultTrains.where((train) {
      StopStations from = train.stopStations
          .firstWhere((element) => element.name == fromStation);
      int departTime = int.parse(from.departTime.split(":")[0]);

      if (departTime >= start && departTime <= end) {
        return true;
      }

      return false;
    }).toList();
  }

  void _twoFilters(int start1, int end1, int start2, int end2) {
    _resultTrains = _resultTrains.where((train) {
      StopStations from = train.stopStations
          .firstWhere((element) => element.name == fromStation);
      int departTime = int.parse(from.departTime.split(":")[0]);

      if (departTime >= start1 && departTime <= end1 ||
          departTime >= start2 && departTime <= end2) {
        return true;
      }

      return false;
    }).toList();
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

    _resultTrains = _trains.where((train) {
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
    _tempTrains = [..._resultTrains];
    notifyListeners();
  }
}
