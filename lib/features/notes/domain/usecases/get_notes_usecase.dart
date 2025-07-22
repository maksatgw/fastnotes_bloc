import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/core/models/user_model.dart';
import 'package:fastnotes_bloc/core/usecases/get_logged_user_use_case.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/paginated_notes_entity.dart';
import 'package:fastnotes_bloc/features/notes/domain/repositories/note_repository.dart';

class GetNotesUsecase {
  final NoteRepository _noteRepository;
  final GetLoggedUserUseCase _getLoggedUserUseCase;

  GetNotesUsecase(this._noteRepository, this._getLoggedUserUseCase);

  // İlk sayfa için
  Future<Either<Failure, PaginatedNotesEntity>> getInitialNotes() async {
    return await _noteRepository.getNotes(1);
  }

  // Belirli bir sayfa için
  Future<Either<Failure, PaginatedNotesEntity>> getNotesForPage(
    int page,
  ) async {
    return await _noteRepository.getNotes(page);
  }

  // Kullanıcı bilgisini al
  Future<UserModel?> getLoggedUser() async {
    final user = await _getLoggedUserUseCase.getLoggedUser();
    return user.fold(
      (failure) => null,
      (success) => success,
    );
  }
}
