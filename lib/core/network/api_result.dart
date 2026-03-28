import 'package:instagram_clone/core/network/api_exception.dart';

sealed class ApiResult<T> {
  const ApiResult();
}

class ApiSuccess<T> extends ApiResult<T> {
  final T data;
  const ApiSuccess(this.data);
}

class ApiFailure<T> extends ApiResult<T> {
  final ApiException exception;
  const ApiFailure(this.exception);
}
