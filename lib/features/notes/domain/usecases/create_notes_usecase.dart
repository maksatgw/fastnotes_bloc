import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/core/utils/validation_utils.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/note_entity.dart';
import 'package:fastnotes_bloc/features/notes/domain/repositories/note_repository.dart';

class CreateNotesUsecase {
  final NoteRepository _noteRepository;

  CreateNotesUsecase(this._noteRepository);

  Future<Either<Failure, bool>> createNote(NoteEntity note) async {
    return await _noteRepository.createNote(note);
  }

  Either<Failure, bool> validateNote(NoteEntity note) {
    final titleValidation = ValidationUtils.validateTextField(
      note.title,
      'Başlık',
      minLength: 3,
      maxLength: 100,
    );

    final contentValidation = ValidationUtils.validateTextField(
      note.content,
      'İçerik',
      minLength: 5,
      maxLength: 1000,
    );

    return titleValidation.fold(
      (failure) => Left(failure),
      (_) => contentValidation.fold(
        (failure) => Left(failure),
        (_) => Right(true),
      ),
    );
  }
}
