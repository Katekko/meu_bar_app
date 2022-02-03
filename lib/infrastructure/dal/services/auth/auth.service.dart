import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/auth_service.interface.dart';
import 'package:ekko/domain/core/exceptions/default.exception.dart';
import 'package:ekko/domain/core/exceptions/user_or_password_wrong.exception.dart';

import 'dto/authenticate_user.body.dart';
import 'dto/authenticate_user.response.dart';

class AuthService implements IAuthService {
  final IHttpConnect _connect;
  const AuthService(IHttpConnect connect) : _connect = connect;

  String get _prefix => 'auth';

  @override
  Future<AuthenticateUserDataResponse> authenticateUser(
    AuthenticateUserBody body,
  ) async {
    final response = await _connect.post(
      '$_prefix/login',
      body.toJson(),
      decoder: AuthenticateUserResponse.fromJson,
    );

    if (response.success) {
      return response.payload!.data!;
    } else {
      final error = response.payload!.errors!.first;
      switch (error.id) {
        case '1':
          throw UserOrPasswordWrongException(message: error.desc);
        default:
          throw DefaultException(message: error.desc);
      }
    }
  }
}
