import 'package:flutter/material.dart';
import 'package:railways/model/journey.dart';
import 'package:railways/model/train.dart';
import 'package:railways/providers/repos/journey_repo.dart';

class JourneyProvider with ChangeNotifier {
  BaseJourneyRepo _baseJourneyRepo = JourneyRepo();
  Future<void> book(
      {@required Train train,
      @required String from,
      @required to,
      @required bookDate,
      @required selectedClass}) async {
    try {
      await _baseJourneyRepo.booking(
          train: train,
          from: from,
          to: to,
          bookDate: bookDate,
          selectedClass: selectedClass);
    } catch (e) {
      throw e;
    }
  }

  Future<Journey> fetchJourney(String trainNum) async {
    return await _baseJourneyRepo.fetchJourney(trainNum);
  }
}
