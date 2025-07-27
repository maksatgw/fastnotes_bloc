import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/core/logging/app_logger.dart';
import 'package:fastnotes_bloc/core/models/user_model.dart';
import 'package:fastnotes_bloc/core/storage/storage_service.dart';

class GetLoggedUserUseCase {
  final StorageService _storageService;
  final AppLogger _appLogger;

  GetLoggedUserUseCase(this._storageService, this._appLogger);

  Future<Either<Failure, UserModel>> getLoggedUser() async {
    try {
      _appLogger.debug('Getting logged user');
      final email = await _storageService.getString("UserEmail");
      final displayName = await _storageService.getString("UserName");
      final photoUrl = await _storageService.getString("UserPhotoUrl");
      if (email == null || displayName == null || photoUrl == null) {
        _appLogger.error('Cached User Data Not Found');
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
      _appLogger.error('Error in getLoggedUser', error: e);
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
