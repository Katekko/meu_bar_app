import 'package:logger/logger.dart';

class UserOrPasswordWrongException implements Exception {
  final String message;
  UserOrPasswordWrongException({this.message = 'Usuario ou senha errados!'}) {
    Logger().w(message);
  }

  @override
  String toString() => message;
}
