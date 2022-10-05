import 'dart:developer';


String formatErrorMsg(dynamic data) {
  if (data is int) {
    return data.toString();
  }

  if (data is String) {
    return data;
  }

  final errorsMap = data['Messages'];

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


