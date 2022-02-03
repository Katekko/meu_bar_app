import 'package:ekko/infrastructure/dal/services/auth/dto/authenticate_user.response.dart';
import 'package:ekko/infrastructure/dal/services/data/user.data.dart';

final responseSuccess = AuthenticateUserDataResponse(
  token: 'token-here',
  user: UserData(
    id: 1,
    name: 'Katekko',
    email: 'contact@gyanburuworld.com',
  ),
);
