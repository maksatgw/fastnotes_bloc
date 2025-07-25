import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';

@freezed
abstract class NoteModel with _$NoteModel {
  const factory NoteModel({
    @JsonKey(includeIfNull: false) final int? id,
    required final String title,
    required final String content,
    @JsonKey(includeIfNull: false) final DateTime? createdAt,
    @JsonKey(includeIfNull: false) final DateTime? updatedAt,
    required final String userId,
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) =>
      _$NoteModelFromJson(json);
}
