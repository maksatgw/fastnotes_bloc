import 'package:fastnotes_bloc/features/notes/domain/entities/paginated_notes_entity.dart';

// NoteRepository arayüzü
// NoteRepository, usecase ve data source arasındaki bağlantıyı sağlar.
abstract class NoteRepository {
  Future<PaginatedNotesEntity?> getNotes(int page);
}
