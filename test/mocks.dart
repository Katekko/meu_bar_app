import 'package:ekko/domain/core/abstractions/domain/repositories/auth_repository.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/http_connect.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/services/auth_service.interface.dart';
import 'package:ekko/domain/core/abstractions/infrastructure/storage.interface.dart';
import 'package:ekko/domain/core/abstractions/presentation/field.interface.dart';
import 'package:ekko/presentation/shared/loading/loading.interface.dart';
import 'package:mocktail/mocktail.dart';

class AuthServiceMock extends Mock implements IAuthService {}

class AuthRepositoryMock extends Mock implements IAuthRepository {}

class LoadingControllerMock extends Mock implements ILoadingController {}

class ConnectMock extends Mock implements IHttpConnect {}

class StorageMock extends Mock implements IStorage {}

class FieldMock extends IField {
  FieldMock({required String value}) : super(value: value, validators: []);

  @override
  Stream<String?> get errorStream => throw UnimplementedError();

  @override
  bool get hasError => throw UnimplementedError();

  @override
  bool validate() => throw UnimplementedError();

  @override
  void dispose() {}
}
