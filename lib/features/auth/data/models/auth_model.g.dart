// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
  token: json['token'] as String,
  refreshToken: json['refreshToken'] as String,
  userId: json['userId'] as String,
);

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
  'token': instance.token,
  'refreshToken': instance.refreshToken,
  'userId': instance.userId,
};
