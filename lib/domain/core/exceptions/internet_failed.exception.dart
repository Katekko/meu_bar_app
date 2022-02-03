import 'package:logger/logger.dart';

class InternetFailedException implements Exception {
  final String message;
  final String? messagePrint;

  InternetFailedException({
    this.message = 'Falha ao conectar com o servidor!',
    this.messagePrint,
  }) {
    Logger().w(message);
    if (messagePrint != null) Logger().i(messagePrint);
  }

  @override
  String toString() => message;
}
