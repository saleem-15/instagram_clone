import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:instagram_clone/features/auth/controllers/auth_controller.dart';
import 'package:mockito/mockito.dart';
import '../../test_mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthController controller;
  late MockStorageService mockStorage;
  late MockAuthService mockAuth;

  setUp(() {
    Get.testMode = true;
    mockStorage = MockStorageService();
    mockAuth = MockAuthService();
  });

  tearDown(() {
    Get.reset();
  });

  group('AuthController Initialization', () {
    test('isAuthorized should be true if token exists', () {
      when(mockStorage.getToken).thenReturn('valid_token');

      controller = AuthController(storage: mockStorage, auth: mockAuth);

      expect(controller.isAuthorized, true);
    });

    test('isAuthorized should be false if token is null', () {
      when(mockStorage.getToken).thenReturn(null);

      controller = AuthController(storage: mockStorage, auth: mockAuth);

      expect(controller.isAuthorized, false);
    });
  });

  group('AuthController Actions', () {
    test('logout should clear storage and notify app', () async {
      when(mockStorage.getToken).thenReturn('valid_token');
      controller = AuthController(storage: mockStorage, auth: mockAuth);

      // Stub logout service call
      when(mockAuth.logout()).thenAnswer((_) async => {});

      controller.logout();

      verify(mockStorage.setUserToken(null)).called(1);
      verify(mockAuth.logout()).called(1);
      expect(controller.isAuthorized, false);
    });

    test('tokenListener should update isAuthorized state', () {
      when(mockStorage.getToken).thenReturn(null);
      controller = AuthController(storage: mockStorage, auth: mockAuth);

      expect(controller.isAuthorized, false);

      controller.tokenListener('new_token');
      expect(controller.isAuthorized, true);

      controller.tokenListener(null);
      expect(controller.isAuthorized, false);
    });
  });
}
