// NoteEntity, gelen verileri UI katmanında kullanmak için oluşturulan entity.
// Business logicler için kullanılır.

class NoteEntity {
  final int? id;
  final String title;
  final String content;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  NoteEntity({
    this.id,
    required this.title,
    required this.content,
    this.createdAt,
    this.updatedAt,
  });
}
