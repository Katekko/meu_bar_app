import 'package:ekko/domain/auth/models/user.model.dart';

abstract class IAuthRepository {
  Future<UserModel> authenticateUser({
    required String login,
    required String password,
  });

  Future<bool> isAuthenticated();
  Future<void> logoutUser();
}
