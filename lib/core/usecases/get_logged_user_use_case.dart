import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/core/models/user_model.dart';
import 'package:fastnotes_bloc/core/storage/storage_service.dart';

class GetLoggedUserUseCase {
  final StorageService _storageService;

  GetLoggedUserUseCase(this._storageService);

  Future<Either<Failure, UserModel>> getLoggedUser() async {
    try {
      final email = await _storageService.getString("UserEmail");
      final displayName = await _storageService.getString("UserName");
      final photoUrl = await _storageService.getString("UserPhotoUrl");
      if (email == null || displayName == null || photoUrl == null) {
        return Left(CacheFailure(message: "Cached User Data Not Found"));
      }
      return Right(
        UserModel(
          email: email,
          displayName: displayName,
          photoUrl: photoUrl,
        ),
      );
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
