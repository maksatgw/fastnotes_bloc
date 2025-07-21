import 'package:fastnotes_bloc/core/models/user_model.dart';
import 'package:fastnotes_bloc/core/usecases/get_logged_user_use_case.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/paginated_notes_entity.dart';
import 'package:fastnotes_bloc/features/notes/domain/repositories/note_repository.dart';

class GetNotesUsecase {
  final NoteRepository _noteRepository;
  final GetLoggedUserUseCase _getLoggedUserUseCase;

  GetNotesUsecase(this._noteRepository, this._getLoggedUserUseCase);

  // İlk sayfa için
  Future<PaginatedNotesEntity?> getInitialNotes() async {
    return await _noteRepository.getNotes(1);
  }

  // Belirli bir sayfa için
  Future<PaginatedNotesEntity?> getNotesForPage(int page) async {
    return await _noteRepository.getNotes(page);
  }

  Future<UserModel?> getLoggedUser() async {
    final user = await _getLoggedUserUseCase.getLoggedUser();
    print(user?.displayName);
    if (user == null) {
      return null;
    }
    return user;
  }
}
