// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticate_user.response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticateUserResponse _$AuthenticateUserResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticateUserResponse(
      success: json['success'] as bool,
      data: json['data'] == null
          ? null
          : AuthenticateUserDataResponse.fromJson(json['data']),
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ErrorData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AuthenticateUserResponseToJson(
        AuthenticateUserResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'data': instance.data,
      'errors': instance.errors,
    };

AuthenticateUserDataResponse _$AuthenticateUserDataResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticateUserDataResponse(
      user: UserData.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
    );

Map<String, dynamic> _$AuthenticateUserDataResponseToJson(
        AuthenticateUserDataResponse instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
    };
