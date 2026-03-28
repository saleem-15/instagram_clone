class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  const ApiException(
    this.message, {
    this.statusCode,
    this.originalError,
  });

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}
