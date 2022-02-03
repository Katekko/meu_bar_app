import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authenticate_user.body.g.dart';

@JsonSerializable()
class AuthenticateUserBody extends Equatable {
  final String login;
  final String password;

  AuthenticateUserBody({
    required String login,
    required String password,
  })  : login = login.trim(),
        password = password.trim();

  factory AuthenticateUserBody.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateUserBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticateUserBodyToJson(this);

  @override
  List<Object?> get props => [login, password];
}
