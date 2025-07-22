import 'package:dartz/dartz.dart';
import 'package:fastnotes_bloc/core/errors/failures.dart';
import 'package:fastnotes_bloc/features/splash/data/datasources/local/splash_local_data_source.dart';
import 'package:fastnotes_bloc/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource _splashLocalDataSource;

  SplashRepositoryImpl(this._splashLocalDataSource);

  @override
  Future<Either<Failure, bool>> checkAuth() async {
    try {
      final result = await _splashLocalDataSource.checkAuth();
      return Right(result);
    } on CacheFailure catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnexpectedFailure(message: e.toString()));
    }
  }
}
