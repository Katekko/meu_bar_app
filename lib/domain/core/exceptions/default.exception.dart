import 'package:logger/logger.dart';

class DefaultException implements Exception {
  final String message;
  DefaultException({
    this.message = 'Erro ao carregar dados, verifique sua internet!',
  }) {
    Logger().e(message);
  }

  @override
  String toString() => message;
}
