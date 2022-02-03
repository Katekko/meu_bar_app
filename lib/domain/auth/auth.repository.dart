import 'package:ekko/domain/auth/models/user.model.dart';
import 'package:ekko/domain/core/abstractions/domain/repositories/auth_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/auth_service.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/storage.interface.dart';
import 'package:ekko/domain/core/constants/storage.constants.dart';
import 'package:ekko/infrastructure/dal/services/auth/dto/authenticate_user.body.dart';

class AuthRepository extends IAuthRepository {
  final IAuthService _authService;
  final IStorage _storage;

  AuthRepository({
    required IAuthService authService,
    required IStorage storage,
  })  : _authService = authService,
        _storage = storage;

  @override
  Future<UserModel> authenticateUser({
    required String login,
    required String password,
  }) async {
    try {
      final body = AuthenticateUserBody(login: login, password: password);
      final response = await _authService.authenticateUser(body);

      // TODO: Essa parte do usuario ainda não foi testada
      // precisamos definir como saber se o user.save foi chamado
      final user = UserModel.fromData(response.user);
      await user.save();

      await _storage.write(
        key: StorageConstants.tokenAuthorization,
        value: response.token,
      );

      return user;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final hasToken = await _storage.hasData(
        StorageConstants.tokenAuthorization,
      );
      final hasUser = await _storage.hasData(StorageConstants.user);
      return hasToken && hasUser;
    } catch (err) {
      rethrow;
    }
  }

  @override
  Future<void> logoutUser() async {
    try {
      await _storage.clear();
    } catch (err) {
      rethrow;
    }
  }
}
