import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:railways/model/journey.dart';
import 'package:railways/model/train.dart';

abstract class BaseJourneyRepo {
  // ignore: unused_element
  Journey _createJournyAndBook(
      // ignore: unused_element
      {@required Train selectedTrain,
      @required String from,
      // ignore: unused_element
      @required to,
      @required bookDate,
      @required num classPrice,
      @required String selectedClass});
  Future<void> booking(
      {@required Train train,
      @required String from,
      @required to,
      @required bookDate,
      @required Map<String, dynamic> selectedClass});
  // ignore: unused_element
  Journey _bookOnExistingJourney(
      {@required Train selectedTrain,
      @required String from,
      to,
      bookDate,
      @required num classPrice,
      @required Journey journey,
      // ignore: unused_element
      @required String selectedClass});

  Future<Journey> fetchJourney(String trainNum);
}

class JourneyRepo implements BaseJourneyRepo {
  @override
  Future<void> booking(
      {@required Train train,
      @required String from,
      @required to,
      @required bookDate,
      @required Map<String, dynamic> selectedClass}) async {
    var collection = FirebaseFirestore.instance.collection('journeys');
    DocumentReference docRef = collection.doc(train.number);
    String degree = selectedClass.keys.first.toString();
    num degreePrice = selectedClass.values.first;

    /// if no journeys created with this train
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final path = await transaction.get(docRef);

      if (!path.exists) {
        Journey journey = _createJournyAndBook(
            to: to,
            from: from,
            classPrice: degreePrice,
            selectedTrain: train,
            selectedClass: degree,
            bookDate: bookDate);
        await collection.doc(train.number).set(journey.toMap());
      }

      /// if booked the train before
      else {
        print("path is exist");
        Journey journey = Journey.fromMap(path.data());
        print(journey.toString());
        journey = _bookOnExistingJourney(
            selectedTrain: train,
            from: from,
            bookDate: bookDate,
            classPrice: degreePrice,
            journey: journey,
            selectedClass: degree);
        transaction.update(docRef, journey.toMap());
      }
    });
  }

  @override
  Journey _bookOnExistingJourney(
      {@required Train selectedTrain,
      @required String from,
      to,
      bookDate,
      @required num classPrice,
      @required Journey journey,
      @required String selectedClass}) {
    Map<String, dynamic> availableSeats = {};
    selectedTrain.fareClassess.entries.forEach((element) {
      availableSeats[element.key] = element.value.noOfSeats;
    });
    journey.profit += classPrice;
    journey.passengers++;

    print("bookDate:$bookDate");
    if ((journey.scheduels.first[from] as Map<String, dynamic>)
        .containsKey(bookDate)) {
      for (int i = 0; i < journey.scheduels.length; i++) {
        String stationName = journey.scheduels[i].keys.first.toString();
        if (stationName == from) {
          for (int j = i; j < journey.scheduels.length; j++) {
            String toName = journey.scheduels[j].keys.first.toString();
            if (toName == to) {
              break;
            } else {
              journey.scheduels[j][toName][bookDate][selectedClass]--;
            }
          }
        } else {
          continue;
        }
      }
    } else {
      for (int i = 0; i < journey.scheduels.length; i++) {
        (journey.scheduels[i][journey.scheduels[i].keys.first]
                as Map<String, dynamic>)
            .putIfAbsent(bookDate, () => {...availableSeats});
      }

      for (int i = 0; i < journey.scheduels.length; i++) {
        String stationName = journey.scheduels[i].keys.first.toString();
        if (stationName == from) {
          for (int j = i; j < journey.scheduels.length; j++) {
            String toName = journey.scheduels[j].keys.first.toString();
            if (toName == to) {
              break;
            } else {
              journey.scheduels[j][toName][bookDate][selectedClass]--;
            }
          }
        } else {
          continue;
        }
      }
    }
    return journey;
  }

  @override
  Journey _createJournyAndBook(
      {@required Train selectedTrain,
      @required String from,
      @required to,
      @required num classPrice,
      @required bookDate,
      @required String selectedClass}) {
    Map<String, dynamic> availableSeats = {};
    selectedTrain.fareClassess.entries.forEach((element) {
      availableSeats[element.key] = element.value.noOfSeats;
    });
    List<Map<String, dynamic>> scheduels = [];
    selectedTrain.stopStations.forEach((s) {
      Map<String, dynamic> stations = {};
      stations[s.name] = {
        ...{
          bookDate: {...availableSeats}
        }
      };
      scheduels.add(stations);
    });

    for (int i = 0; i < scheduels.length; i++) {
      String stationName = scheduels[i].keys.first.toString();
      if (stationName == from) {
        for (int j = i; j < scheduels.length; j++) {
          String toName = scheduels[j].keys.first.toString();
          if (toName == to) {
            break;
          } else {
            scheduels[j][toName][bookDate][selectedClass]--;
          }
        }
      } else {
        continue;
      }
    }
    Journey journey =
        Journey(scheduels: scheduels, passengers: 1, profit: classPrice);
    return journey;
  }

  @override
  Future<Journey> fetchJourney(String trainNum) async {
    final journeyMap = await FirebaseFirestore.instance
        .collection("journeys")
        .doc(trainNum)
        .get();

    return Journey.fromMap(journeyMap.data());
  }
}
