import 'package:logger/logger.dart';

class TimeOutException implements Exception {
  final String message;
  final String? messagePrint;

  TimeOutException({
    this.message = 'Timeout ao se tentar conectar n servidor',
    this.messagePrint,
  }) {
    Logger().w(message);
    if (messagePrint != null) Logger().i(messagePrint);
  }

  @override
  String toString() => message;
}
