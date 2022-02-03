import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/auth_service.interface.dart';
import 'package:ekko/domain/core/exceptions/default.exception.dart';
import 'package:ekko/domain/core/exceptions/user_or_password_wrong.exception.dart';
import 'package:ekko/infrastructure/dal/services/auth/auth.service.dart';
import 'package:ekko/infrastructure/dal/services/auth/dto/authenticate_user.body.dart';
import 'package:ekko/infrastructure/dal/services/auth/dto/authenticate_user.response.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mocks.dart';
import 'mocks/auth_mocks/authenticate_user.mocks.dart';

void main() {
  late IHttpConnect connect;
  late IAuthService authService;

  setUpAll(() {
    connect = ConnectMock();
    authService = AuthService(connect);
  });

  group('Authentication', () {
    test(
      'Should authenticate user with success',
      () async {
        when(
          () => connect.post<AuthenticateUserResponse>(
            'auth/login',
            any(),
            decoder: any(named: 'decoder'),
          ),
        ).thenAnswer((_) async => successResponse);

        final response = await authService.authenticateUser(
          AuthenticateUserBody(login: 'katekko', password: '123'),
        );

        expect(response, successResponse.payload!.data!);
      },
    );

    test(
      'Should throw UserOrPasswordWrongException',
      () async {
        when(
          () => connect.post<AuthenticateUserResponse>(
            'auth/login',
            any(),
            decoder: any(named: 'decoder'),
          ),
        ).thenAnswer((_) async => userOrPasswordExceptionResponse);

        final future = authService.authenticateUser(
          AuthenticateUserBody(login: 'katekko', password: '123'),
        );

        expect(future, throwsA(isA<UserOrPasswordWrongException>()));
      },
    );

    test(
      'Should throw DefaultException',
      () async {
        when(
          () => connect.post<AuthenticateUserResponse>(
            'auth/login',
            any(),
            decoder: any(named: 'decoder'),
          ),
        ).thenAnswer((_) async => defaultExceptionResponse);

        final future = authService.authenticateUser(
          AuthenticateUserBody(login: 'katekko', password: '123'),
        );

        expect(future, throwsA(isA<DefaultException>()));
      },
    );
  });
}
