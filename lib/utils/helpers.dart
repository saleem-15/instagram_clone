import 'dart:developer';

import 'package:flutter/cupertino.dart';

String formatErrorMsg(dynamic data) {
  if (data is int) {
    return data.toString();
  }

  if (data is String) {
    return data;
  }

  final errorsMap = data['Messages'];

  if (errorsMap == null) {
    return data.toString();
  }

  if (errorsMap is String) {
    return errorsMap;
  }
  log(data.toString());

  // log('error msg type: ${errorsMap.runtimeType}');
  //the error map is Map<String,List<String>>
  String errorString = '';

  for (var value in errorsMap.values) {
    for (var e in (value as List)) {
      log('value: $e');
      errorString += '$e\n';
    }
  }

  // remove the last (\n)
  errorString = errorString.substring(0, errorString.length - 2);

  return errorString;
}

extension JsonExtensions on Map {
  void printMap({List<String> ignoreValues = const []}) {
    log('{');
    for (final key in keys) {
      final value = this[key];
      if (ignoreValues.contains(key)) {
        continue;
      }
      debugPrint('   $key: ');

      if (value is Map) {
        value.printMap();
        log(',');
      }
      if (value is List) {
        value.printList();
        log(',');
      }

      if (value is! List && value is! Map) {
        log('${this[key].toString()},\n');
      }
    }
    log('}');
  }
}

extension ListExtensions on List {
  void printList() {
    log('[');
    for (final entry in this) {
      if (entry is Map) {
        entry.printMap();
      }
      if (entry is List) {
        entry.printList();
      }

      if (entry is num || entry is bool) {
        log('$entry,');
      } else {
        log(entry.toString());
      }
    }
    log(']');
  }
}
