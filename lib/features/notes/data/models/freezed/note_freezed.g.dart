// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_freezed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NoteDataModel _$NoteDataModelFromJson(Map<String, dynamic> json) =>
    _NoteDataModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      content: json['content'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      userId: json['userId'] as String?,
    );

Map<String, dynamic> _$NoteDataModelToJson(_NoteDataModel instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'title': ?instance.title,
      'content': ?instance.content,
      'createdAt': ?instance.createdAt?.toIso8601String(),
      'updatedAt': ?instance.updatedAt?.toIso8601String(),
      'userId': ?instance.userId,
    };
