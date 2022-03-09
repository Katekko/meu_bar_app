import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

class DefaultException extends Equatable implements Exception {
  final String message;
  DefaultException({
    this.message = 'Erro ao carregar dados, verifique sua internet!',
  }) {
    Logger().e(message);
  }

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];
}
