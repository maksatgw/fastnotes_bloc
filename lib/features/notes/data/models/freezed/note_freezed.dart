import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_freezed.freezed.dart';
part 'note_freezed.g.dart';

@freezed
// @JsonSerializable(includeIfNull: false)
abstract class NoteDataModel with _$NoteDataModel {
  const factory NoteDataModel({
    @JsonKey(includeIfNull: false) int? id,
    @JsonKey(includeIfNull: false) String? title,
    @JsonKey(includeIfNull: false) String? content,
    @JsonKey(includeIfNull: false) DateTime? createdAt,
    @JsonKey(includeIfNull: false) DateTime? updatedAt,
    @JsonKey(includeIfNull: false) String? userId,
  }) = _NoteDataModel;

  factory NoteDataModel.fromJson(Map<String, dynamic> json) =>
      _$NoteDataModelFromJson(json);

  // // Özel bir toJson davranışı için extension metodu
  // const NoteFreezed._(); // u satır özel metodlar için gerekli

  // Map<String, dynamic> createToJson() {
  //   // Normal toJson'i çağırıp üzerinde değişiklik yapabilirsiniz
  //   final json = toJson();
  //   json['userId'] = this.userId;
  //   json['title'] = this.title;
  //   json['content'] = this.content;
  //   return json;
  // }
}
