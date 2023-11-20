class CustomMessageException implements Exception {
  final String? message;
  CustomMessageException(this.message);

  @override
  String toString() =>
      message ??
      'An error occurred, please take a look at the logs or contact Session Mate team.';
}
