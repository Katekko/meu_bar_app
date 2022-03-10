import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';

class TableNameAlreadyExistsException extends Equatable implements Exception {
  final String message;
  TableNameAlreadyExistsException({
    this.message = 'Nome da mesa já esstá sendo utilizado',
  }) {
    Logger().w(message);
  }

  @override
  String toString() => message;

  @override
  List<Object?> get props => [message];
}
