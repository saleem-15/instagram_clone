import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Centralized logging utility for production-level standard.
class AppLogger {
  static final Logger _logger = Logger(
    // The logger only enables in Debug mode for performance and data security.
    filter: kDebugMode ? DevelopmentFilter() : ProductionFilter(),

    // Professional colored formatting.
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to display.

      // Number of method calls to display if stacktrace is provided.
      errorMethodCount: 8,
      lineLength: 120, // Width of the output.
      colors: true, // Colorful log messages.
      printEmojis: true, // Print an emoji for each log message (💡, ⚠️, ❌).

      // Should each log print contain a timestamp.
      dateTimeFormat: DateTimeFormat.none,
      excludePaths: ['package:instagram_clone/core/utils/logger.dart'],
    ),
  );

  /// Informational log (General info and tracking).
  static void info(dynamic message) {
    _logger.i(message);
  }

  /// Debugging log (For development variables).
  static void debug(dynamic message) {
    _logger.d(message);
  }

  /// Warning log (For unexpected but non-critical events).
  static void warning(dynamic message) {
    _logger.w(message);
  }

  /// Error log (For exceptions and critical failures).
  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);

    // TODO: In production, forward this error to Crashlytics or Sentry.
    if (kReleaseMode) {
      // FirebaseCrashlytics.instance.recordError(error, stackTrace, reason: message);
    }
  }

  /// Success log (Preferably used for successful API or DB operations).
  static void success(dynamic message) {
    // Triggers a light (trace) log with a checkmark.
    _logger.t('✅ $message');
  }
}
