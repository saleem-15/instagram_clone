/// Base class for all application specific exceptions.
abstract class AppException implements Exception {
  final String message;
  final String? prefix;

  AppException(this.message, [this.prefix]);

  @override
  String toString() {
    return "${prefix ?? ''}: $message";
  }
}

/// Exception thrown when there is a network connectivity issue.
class NetworkException extends AppException {
  NetworkException([String message = 'No Internet Connection'])
      : super(message, "Network Error");
}

/// Exception thrown when the server returns an error.
class ServerException extends AppException {
  ServerException([String message = 'Internal Server Error'])
      : super(message, "Server Error");
}

/// Exception thrown when there is an error accessing the local cache.
class CacheException extends AppException {
  CacheException([String message = 'Cache Access Error'])
      : super(message, "Cache Error");
}

/// Exception thrown when an unknown error occurs.
class UnknownException extends AppException {
  UnknownException([String message = 'An unexpected error occurred'])
      : super(message, "Unknown Error");
}
