import 'package:ekko/domain/auth/auth.repository.dart';
import 'package:ekko/domain/core/abstractions/domain/repositories/auth_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/storage.interface.dart';
import 'package:ekko/infrastructure/dal/inject.dart';
import 'package:ekko/infrastructure/dal/services/auth/auth.service.mock.dart';

class AuthRepositoryBinding {
  late IAuthRepository _authRepository;
  IAuthRepository get repository => _authRepository;

  AuthRepositoryBinding() {
    final storage = Inject.find<IStorage>();
    // TODO: Mockado para utilizar o service mock
    // final connect = Inject.find<IHttpConnect>();
    // final authService = AuthService(connect);
    final authService = AuthServiceMock();
    _authRepository = AuthRepository(
      authService: authService,
      storage: storage,
    );
  }
}
