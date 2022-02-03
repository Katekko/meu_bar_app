import 'package:ekko/domain/core/exceptions/internet_failed.exception.dart';
import 'package:ekko/domain/core/exceptions/time_out.exception.dart';

void verifyResponse({required String? statusText}) {
  final semConexao = statusText?.contains('SocketException') ?? false;
  final timeOut = statusText?.toLowerCase().contains('timeout') ?? false;

  if (semConexao) {
    throw InternetFailedException(
      message: 'Falha ao se conectar com o servidor.',
      messagePrint: statusText,
    );
  }

  if (timeOut) {
    throw TimeOutException(
      message: 'Tempo de resposta esgotado! Tente novamente.',
      messagePrint: statusText,
    );
  }
}
