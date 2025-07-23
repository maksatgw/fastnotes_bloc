import 'package:fastnotes_bloc/core/storage/storage_service.dart';

abstract class NoteLocalDataSource {
  Future<String?> getUserId();
}

class NoteLocalDataSourceImpl implements NoteLocalDataSource {
  final StorageService _storageService;

  NoteLocalDataSourceImpl(this._storageService);

  @override
  Future<String?> getUserId() async {
    return await _storageService.getString("userId");
  }
}
