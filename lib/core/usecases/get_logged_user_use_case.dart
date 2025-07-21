import 'package:fastnotes_bloc/core/models/user_model.dart';
import 'package:fastnotes_bloc/core/storage/storage_service.dart';

class GetLoggedUserUseCase {
  final StorageService _storageService;

  GetLoggedUserUseCase(this._storageService);

  Future<UserModel?> getLoggedUser() async {
    final email = await _storageService.getString("UserEmail");
    final displayName = await _storageService.getString("UserName");
    final photoUrl = await _storageService.getString("UserPhotoUrl");
    if (email == null || displayName == null || photoUrl == null) {
      return null;
    }
    return UserModel(
      email: email,
      displayName: displayName,
      photoUrl: photoUrl,
    );
  }
}
