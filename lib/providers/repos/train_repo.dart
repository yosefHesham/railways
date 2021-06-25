import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:railways/model/train.dart';

abstract class BaseTrainRepo {
  Future<List<void>> getTrains();
}

class TrainRepo extends BaseTrainRepo {
  @override
  Future<List<Train>> getTrains() async {
    try {
      List<Train> trains = [];
      final trainsData =
          await FirebaseFirestore.instance.collection('trains').get();
      trainsData.docs.forEach((train) {
        trains.add(Train.fromMap(train.data()));
      });

      return trains;
    } catch (x) {
      print(x);
      throw x;
    }
  }
}
