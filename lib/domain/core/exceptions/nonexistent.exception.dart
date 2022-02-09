import 'package:logger/logger.dart';

class NonexistentException implements Exception {
  final String message;
  NonexistentException({this.message = 'Nonexistent item'}) {
    Logger().w(message);
  }

  @override
  String toString() => message;
}
