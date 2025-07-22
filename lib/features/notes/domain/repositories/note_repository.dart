import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/paginated_notes_entity.dart';

// NoteRepository arayüzü
// NoteRepository, usecase ve data source arasındaki bağlantıyı sağlar.
abstract class NoteRepository {
  Future<Either<Failure, PaginatedNotesEntity>> getNotes(int page);
}
