class ServerException implements Exception {
  ServerException([this.message = 'An unknown server error occurred']);
  final String message;

  @override
  String toString() => 'ServerException: $message';
}
