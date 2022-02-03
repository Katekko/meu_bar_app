import 'package:ekko/domain/core/abstractions/infrastructure/services/auth_service.interface.dart';
import 'package:ekko/domain/core/exceptions/user_or_password_wrong.exception.dart';
import 'package:ekko/infrastructure/dal/services/auth/dto/authenticate_user.response.dart';
import 'package:ekko/infrastructure/dal/services/auth/dto/authenticate_user.body.dart';
import 'package:ekko/infrastructure/dal/services/data/user.data.dart';

class AuthServiceMock implements IAuthService {
  @override
  Future<AuthenticateUserDataResponse> authenticateUser(
    AuthenticateUserBody body,
  ) async {
    await Future.delayed(const Duration(seconds: 2));
    if (body.login.toLowerCase() == 'katekko' && body.password == '123456') {
      return Future.value(
        AuthenticateUserDataResponse(
          token: 'jwtToken',
          user: UserData(
            id: 1,
            name: 'Katekko',
            email: 'contact@gyanburuworld.com',
          ),
        ),
      );
    } else {
      throw UserOrPasswordWrongException();
    }
  }
}
