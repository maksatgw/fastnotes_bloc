import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/features/notes/data/datasources/local/note_local_data_source.dart';
import 'package:fastnotes_bloc/features/notes/data/datasources/remote/note_remote_data_source.dart';
import 'package:fastnotes_bloc/features/notes/data/models/note_model.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/note_entity.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/paginated_notes_entity.dart';
import 'package:fastnotes_bloc/features/notes/domain/repositories/note_repository.dart';

// NoteRepository implementasyonu

class NoteRepositoryImpl implements NoteRepository {
  // NoteRemoteDataSource'ı bu katmanda kullanıyoruz.
  // DI Containertdan singleton nesne olarak verilecek.
  final NoteRemoteDataSource _noteRemoteDataSource;
  final NoteLocalDataSource _noteLocalDataSource;

  // Constructor
  NoteRepositoryImpl(this._noteRemoteDataSource, this._noteLocalDataSource);

  // GetNotes fonksiyonu, API'den notları çeker.
  @override
  Future<Either<Failure, PaginatedNotesEntity>> getNotes(int page) async {
    // Try catch ile hata yakalama
    try {
      var userId = await _noteLocalDataSource.getUserId();
      if (userId == null) {
        return Left(CacheFailure(message: 'User ID is null'));
      }
      var response = await _noteRemoteDataSource.getNotes(page, userId);

      if (response == null) {
        return Left(ServerFailure(message: 'Response is null'));
      }
      var entity = PaginatedNotesEntity(
        notes: response.value
            .map(
              (noteModel) => NoteEntity(
                id: noteModel.id ?? 0,
                title: noteModel.title,
                content: noteModel.content,
                createdAt: noteModel.createdAt ?? DateTime.now(),
                updatedAt: noteModel.updatedAt ?? DateTime.now(),
              ),
            )
            .toList(),
        hasNext: response.hasNext,
        pageNumber: response.pageNumber,
      );

      // NoteEntity'e dönüştürüyoruz.
      return Right(entity);
    } on ServerFailure catch (e) {
      return Left(e);
    } on CacheFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> createNote(NoteEntity note) async {
    try {
      var userId = await _noteLocalDataSource.getUserId();
      if (userId == null) {
        return Left(CacheFailure(message: 'User ID is null'));
      }
      var response = await _noteRemoteDataSource.createNote(
        NoteModel(
          title: note.title,
          content: note.content,
          userId: userId,
        ),
      );
      return Right(response);
    } on ServerFailure catch (e) {
      return Left(e);
    } on CacheFailure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
