import 'package:fastnotes_bloc/core/config/constants/api_constants.dart';
import 'package:fastnotes_bloc/core/models/paginated_response_model.dart';
import 'package:fastnotes_bloc/core/network/api_client.dart';
import 'package:fastnotes_bloc/features/notes/data/models/note_model.dart';

// Uzak veri kaynağı için arayüz
abstract class NoteRemoteDataSource {
  Future<PaginatedResponseModel<NoteModel>?> getNotes(int page, String userId);
  Future<bool> createNote(NoteModel note);
}

// Uzak veri kaynağı için implementasyon
class NoteRemoteDataSourceImpl implements NoteRemoteDataSource {
  // API Client'ı bu katmanda kullanıyoruz.
  // DI Containertdan singleton nesne olarak verilecek.
  final ApiClient _apiClient;

  // Constructor
  NoteRemoteDataSourceImpl(this._apiClient);

  // GetNotes fonksiyonu, API'den notları çeker.
  @override
  Future<PaginatedResponseModel<NoteModel>?> getNotes(
    int page,
    String userId,
  ) async {
    var response = await _apiClient.get(
      ApiConstants.notes,
      // TODO: pageSize'ı kullanıcının tercihine göre ayarlayın
      queryParameters: {
        'pageNumber': page,
        'pageSize': 15,
        'userId': userId,
      },
    );

    // Eğer response null ise, null dönüyoruz.
    if (response == null) return null;

    // PaginatedResponseModel'a dönüştürüyoruz.
    return PaginatedResponseModel.fromJson(
      response,
      (json) => NoteModel.fromJson(json as Map<String, dynamic>),
    );
  }

  @override
  Future<bool> createNote(NoteModel note) async {
    var response = await _apiClient.post(
      ApiConstants.notes,
      data: note.toJson(),
    );
    return response != null;
  }
}
