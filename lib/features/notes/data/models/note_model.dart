import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

// NoteModel, API'den gelen verileri tutan model.

@JsonSerializable()
class NoteModel {
  final int? id;
  final String title;
  final String content;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String userId;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    this.createdAt,
    this.updatedAt,
    required this.userId,
  });

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);

  //TODO: Sorulacak. toJson yönetiminin böyle olması gerekiyor mu?
  Map<String, dynamic> toJson() => _$NoteModelToJson(this);

  // Create işlemi için özel toJson metodu - id, createdAt ve updatedAt içermez
  Map<String, dynamic> toJsonForCreate() => {
    'title': title,
    'content': content,
    'userId': userId,
  };
}
