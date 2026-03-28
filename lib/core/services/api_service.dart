import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:instagram_clone/core/utils/constants/api.dart';
import 'package:instagram_clone/core/network/api_exception.dart';

/// [ApiService] is a base service used to perform all network operations.
/// It wraps around the [Dio] client and provides methods for GET, POST, PUT, and DELETE.
/// It includes centralized error handling and authentication token management.
class ApiService extends GetxService {
  late final Dio _dio;
  final Logger _logger = Get.find<Logger>();

  static ApiService get to => Get.find();

  /// Initializes the [ApiService] with base options and interceptors.
  Future<ApiService> init() async {
    _dio = Dio(
      BaseOptions(
        baseUrl: Api.apiUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'apiKey': Api.apikey,
          'ngrok-skip-browser-warning': 'any-value',
        },
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = Get.find<StorageService>().getToken;
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          // Log errors only in debug mode
          if (!kReleaseMode) {
            _logger.e(
              'API ERROR [${e.response?.statusCode}] => PATH: ${e.requestOptions.path}\n'
              'MESSAGE: ${e.message}',
            );
          }
          return handler.next(e);
        },
      ),
    );

    return this;
  }

  /// Wraps a Dio request with safe error handling and rethrows as [ApiException].
  Future<Response> _safeRequest(Future<Response> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      String message = 'Something went wrong';
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        message = 'Connection timed out';
      } else if (e.type == DioExceptionType.connectionError) {
        message = 'No internet connection';
      } else if (e.response?.data != null) {
        // Here we could extract more detailed messages from the API response
        message = e.response?.data.toString() ?? e.message ?? message;
      }

      throw ApiException(
        message,
        statusCode: e.response?.statusCode,
        originalError: e,
      );
    } catch (e) {
      throw ApiException(e.toString());
    }
  }

  /// Sends a GET request and returns the [Response].
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return _safeRequest(() => _dio.get(
          path,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        ));
  }

  /// Sends a POST request and returns the [Response].
  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return _safeRequest(() => _dio.post(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ));
  }

  /// Sends a PUT request and returns the [Response].
  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    return _safeRequest(() => _dio.put(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        ));
  }

  /// Sends a DELETE request and returns the [Response].
  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    return _safeRequest(() => _dio.delete(
          path,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
        ));
  }
}
