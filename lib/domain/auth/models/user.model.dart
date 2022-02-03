import 'package:ekko/domain/core/abstractions/infrastructure/storage.interface.dart';
import 'package:ekko/domain/core/constants/storage.constants.dart';
import 'package:ekko/infrastructure/dal/inject.dart';
import 'package:ekko/infrastructure/dal/services/data/user.data.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name, email;
  const UserModel({required this.name, required this.email});

  factory UserModel.fromData(UserData data) {
    return UserModel(name: data.name, email: data.email);
  }

  static Future<UserModel?> fromStorage() async {
    final storage = Inject.find<IStorage>();
    final user = await storage.read<UserModel>('user');
    return user;
  }

  Future<void> save() async {
    final storage = Inject.find<IStorage>();
    await storage.write(
      key: StorageConstants.user,
      value: {'name': name, 'email': email},
    );
  }

  @override
  List<Object?> get props => [name, email];
}
