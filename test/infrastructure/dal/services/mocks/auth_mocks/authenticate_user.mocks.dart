import 'package:ekko/domain/core/abstractions/infrastructure/response.model.dart';
import 'package:ekko/domain/core/constants/errors.constants.dart';
import 'package:ekko/infrastructure/dal/services/auth/dto/authenticate_user.response.dart';
import 'package:ekko/infrastructure/dal/services/data/error.data.dart';
import 'package:ekko/infrastructure/dal/services/data/user.data.dart';

final successResponse = Response(
  statusCode: 200,
  payload: AuthenticateUserResponse(
    success: true,
    errors: null,
    data: AuthenticateUserDataResponse(
      token: 'token-here',
      user: UserData(
        id: 1,
        name: 'Katekko',
        email: 'contact@gyanburuworld.com',
      ),
    ),
  ),
);

const userOrPasswordExceptionResponse = Response(
  statusCode: 400,
  payload: AuthenticateUserResponse(
    success: false,
    errors: [
      ErrorData(
        id: ErrosConstants.userOrPasswordWrong,
        desc: 'User or password wrong',
      )
    ],
    data: null,
  ),
);

const defaultExceptionResponse = Response(
  statusCode: 400,
  payload: AuthenticateUserResponse(
    success: false,
    errors: [ErrorData(id: ErrosConstants.unknow, desc: 'Unknow error')],
    data: null,
  ),
);
