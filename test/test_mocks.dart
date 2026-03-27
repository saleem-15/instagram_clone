import 'package:dio/dio.dart';
import 'package:instagram_clone/core/services/api_service.dart';
import 'package:instagram_clone/core/services/storage_service.dart';
import 'package:instagram_clone/features/auth/services/auth_service.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<ApiService>(),
  MockSpec<StorageService>(),
  MockSpec<AuthService>(),
  MockSpec<Dio>(),
])
void main() {}
