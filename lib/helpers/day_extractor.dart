extension DayExtractor on String {
  String extractDay() {
    List dateSplitted = this.split(',');

    return dateSplitted[0].toString().toLowerCase();
  }
}
