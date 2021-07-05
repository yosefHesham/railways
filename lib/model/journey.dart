class Journey {
  int passengers;
  int profit;
  List<Map<dynamic, dynamic>> scheduels;
  Journey({this.passengers, this.profit, this.scheduels});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> journeyMap = {};

    journeyMap['passengers'] = this.passengers;
    journeyMap['profit'] = this.profit;
    journeyMap['scheduels'] = this.scheduels;
    return journeyMap;
  }

  Journey.fromMap(Map<String, dynamic> journeyMap) {
    this.passengers = journeyMap['passengers'];
    this.profit = journeyMap['profit'];
    this.scheduels = (journeyMap['scheduels'] as List<dynamic>)
        .map((e) => {e.entries.first.key: e.entries.first.value})
        .toList();
  }
}
