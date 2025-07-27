import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/features/notes/domain/repositories/note_repository.dart';

class DeleteNotesUsecase {
  final NoteRepository _noteRepository;

  DeleteNotesUsecase(this._noteRepository);

  Future<Either<Failure, bool>> deleteNote(int id) async {
    return await _noteRepository.deleteNote(id);
  }
}
