import 'package:fastnotes_bloc/features/notes/domain/entities/note_entity.dart';

// PaginatedNotesEntity, API'den dönen verileri entity'e dönüştürmek için kullanılır.
class PaginatedNotesEntity {
  final List<NoteEntity> notes;
  final int pageNumber;
  final bool hasNext;

  PaginatedNotesEntity({
    required this.notes,
    required this.pageNumber,
    required this.hasNext,
  });
}
