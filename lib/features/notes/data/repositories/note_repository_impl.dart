import 'package:fastnotes_bloc/features/notes/data/datasources/remote/note_remote_data_source.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/note_entity.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/paginated_notes_entity.dart';
import 'package:fastnotes_bloc/features/notes/domain/repositories/note_repository.dart';

// NoteRepository implementasyonu

class NoteRepositoryImpl implements NoteRepository {
  // NoteRemoteDataSource'ı bu katmanda kullanıyoruz.
  // DI Containertdan singleton nesne olarak verilecek.
  final NoteRemoteDataSource _noteRemoteDataSource;

  // Constructor
  NoteRepositoryImpl(this._noteRemoteDataSource);

  // GetNotes fonksiyonu, API'den notları çeker.
  @override
  Future<PaginatedNotesEntity?> getNotes(int page) async {
    // NoteRemoteDataSource'dan notları çeker.
    var response = await _noteRemoteDataSource.getNotes(page);

    // Eğer response null ise, null dönüyoruz.
    if (response == null) return null;

    // NoteEntity'e dönüştürüyoruz.
    return PaginatedNotesEntity(
      notes: response.value
          .map(
            (noteModel) => NoteEntity(
              id: noteModel.id,
              title: noteModel.title,
              content: noteModel.content,
              createdAt: noteModel.createdAt,
              updatedAt: noteModel.updatedAt,
            ),
          )
          .toList(),
      hasNext: response.hasNext,
      pageNumber: response.pageNumber,
    );
  }
}
