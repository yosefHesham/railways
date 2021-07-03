class GoogleException implements Exception {
  final String message;

  GoogleException(this.message);

  @override
  String toString() {
    return message;
    // return super.toString(); // Instance of HttpException
  }
}
