import 'package:fastnotes_bloc/core/storage/storage_service.dart';

void clearUserData(StorageService storageService) {
  storageService.remove("token");
  storageService.remove("refreshToken");
  storageService.remove("userId");
  storageService.remove("UserEmail");
  storageService.remove("UserName");
  storageService.remove("UserPhotoUrl");
}
