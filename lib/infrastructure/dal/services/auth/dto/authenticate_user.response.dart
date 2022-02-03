import 'package:ekko/infrastructure/dal/services/data/error.data.dart';
import 'package:ekko/infrastructure/dal/services/data/user.data.dart';

import 'package:json_annotation/json_annotation.dart';

part 'authenticate_user.response.g.dart';

@JsonSerializable()
class AuthenticateUserResponse {
  final bool success;
  final AuthenticateUserDataResponse? data;
  final List<ErrorData>? errors;

  const AuthenticateUserResponse({
    required this.success,
    required this.data,
    required this.errors,
  });

  factory AuthenticateUserResponse.fromJson(json) =>
      _$AuthenticateUserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticateUserResponseToJson(this);
}

@JsonSerializable()
class AuthenticateUserDataResponse {
  final UserData user;
  final String token;
  const AuthenticateUserDataResponse({required this.user, required this.token});

  factory AuthenticateUserDataResponse.fromJson(json) =>
      _$AuthenticateUserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticateUserDataResponseToJson(this);
}
