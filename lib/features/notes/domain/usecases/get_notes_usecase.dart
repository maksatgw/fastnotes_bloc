import 'package:fastnotes_bloc/features/notes/domain/entities/paginated_notes_entity.dart';
import 'package:fastnotes_bloc/features/notes/domain/repositories/note_repository.dart';

class GetNotesUsecase {
  final NoteRepository _noteRepository;

  GetNotesUsecase(this._noteRepository);

  // İlk sayfa için
  Future<PaginatedNotesEntity?> getInitialNotes() async {
    return await _noteRepository.getNotes(1);
  }

  // Belirli bir sayfa için
  Future<PaginatedNotesEntity?> getNotesForPage(int page) async {
    return await _noteRepository.getNotes(page);
  }
}
