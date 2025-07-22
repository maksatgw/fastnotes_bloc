import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/features/splash/domain/repositories/splash_repository.dart';

class SplashUseCase {
  final SplashRepository _splashRepository;

  SplashUseCase(this._splashRepository);

  Future<Either<Failure, bool>> checkAuth() async {
    return await _splashRepository.checkAuth();
  }
}
