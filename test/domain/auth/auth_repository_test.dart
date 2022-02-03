import 'package:ekko/domain/auth/auth.repository.dart';
import 'package:ekko/domain/auth/models/user.model.dart';
import 'package:ekko/domain/core/abstractions/domain/repositories/auth_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/auth_service.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/storage.interface.dart';
import 'package:ekko/domain/core/constants/storage.constants.dart';
import 'package:ekko/infrastructure/dal/inject.dart';
import 'package:ekko/infrastructure/dal/services/auth/dto/authenticate_user.body.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../mocks.dart';
import 'mocks/authenticate_user.mock.dart';

void main() {
  late IAuthRepository authRepository;
  late IAuthService authService;
  late IStorage storage;

  setUpAll(() {
    authService = AuthServiceMock();
    storage = StorageMock();

    authRepository = AuthRepository(authService: authService, storage: storage);

    Inject.put<IStorage>(() => storage);
  });

  test('Authenticate user with success', () async {
    const login = 'any_login';
    const password = 'any_password';

    when(
      () => authService.authenticateUser(
        AuthenticateUserBody(login: login, password: password),
      ),
    ).thenAnswer((_) async => responseSuccess);

    when(
      () => storage.write(key: any(named: 'key'), value: any(named: 'value')),
    ).thenAnswer((i) async => {});

    final response = await authRepository.authenticateUser(
      login: login,
      password: password,
    );

    final model = UserModel.fromData(responseSuccess.user);

    expect(response, model);

    verify(
      () => storage.write(
        key: StorageConstants.tokenAuthorization,
        value: responseSuccess.token,
      ),
    );
  });

  test('isAuthenticated should return true when user is logged in', () async {
    when(
      () => storage.hasData(StorageConstants.tokenAuthorization),
    ).thenAnswer((_) async => true);

    when(
      () => storage.hasData(StorageConstants.user),
    ).thenAnswer((_) async => true);

    final response = await authRepository.isAuthenticated();

    expect(response, true);
    verify(() => storage.hasData(StorageConstants.tokenAuthorization));
    verify(() => storage.hasData(StorageConstants.user));
  });

  test('isAuthenticated should return false when token is null', () async {
    when(
      () => storage.hasData(StorageConstants.tokenAuthorization),
    ).thenAnswer((_) async => false);

    when(
      () => storage.hasData(StorageConstants.user),
    ).thenAnswer((_) async => true);

    final response = await authRepository.isAuthenticated();

    expect(response, false);
    verify(() => storage.hasData(StorageConstants.tokenAuthorization));
    verify(() => storage.hasData(StorageConstants.user));
  });

  test('isAuthenticated should return false when user is null', () async {
    when(
      () => storage.hasData(StorageConstants.tokenAuthorization),
    ).thenAnswer((_) async => true);

    when(
      () => storage.hasData(StorageConstants.user),
    ).thenAnswer((_) async => false);

    final response = await authRepository.isAuthenticated();

    expect(response, false);
    verify(() => storage.hasData(StorageConstants.tokenAuthorization));
    verify(() => storage.hasData(StorageConstants.user));
  });

  test('isAuthenticated should return false when user and token are null',
      () async {
    when(
      () => storage.hasData(StorageConstants.tokenAuthorization),
    ).thenAnswer((_) async => false);

    when(
      () => storage.hasData(StorageConstants.user),
    ).thenAnswer((_) async => false);

    final response = await authRepository.isAuthenticated();

    expect(response, false);
    verify(() => storage.hasData(StorageConstants.tokenAuthorization));
    verify(() => storage.hasData(StorageConstants.user));
  });

  test('logoutUser should call storage clear', () async {
    when(() => storage.clear()).thenAnswer((_) async => {});

    await authRepository.logoutUser();

    verify(() => storage.clear());
  });
}
