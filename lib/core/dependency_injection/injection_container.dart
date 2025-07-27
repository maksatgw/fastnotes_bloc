import 'package:fastnotes_bloc/core/logging/app_logger.dart';
import 'package:fastnotes_bloc/core/network/api_client.dart';
import 'package:fastnotes_bloc/core/network/auth_interceptor.dart';
import 'package:fastnotes_bloc/core/storage/storage_service.dart';
import 'package:fastnotes_bloc/core/usecases/get_logged_user_use_case.dart';
import 'package:fastnotes_bloc/features/auth/data/datasources/local/auth_local_data_source.dart';
import 'package:fastnotes_bloc/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:fastnotes_bloc/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fastnotes_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:fastnotes_bloc/features/auth/domain/usecases/auth_usecase.dart';
import 'package:fastnotes_bloc/features/notes/data/datasources/local/note_local_data_source.dart';
import 'package:fastnotes_bloc/features/notes/data/datasources/remote/note_remote_data_source.dart';
import 'package:fastnotes_bloc/features/notes/data/repositories/note_repository_impl.dart';
import 'package:fastnotes_bloc/features/notes/domain/repositories/note_repository.dart';
import 'package:fastnotes_bloc/features/notes/domain/usecases/create_notes_usecase.dart';
import 'package:fastnotes_bloc/features/notes/domain/usecases/delete_notes_usecase.dart';
import 'package:fastnotes_bloc/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:fastnotes_bloc/features/onboarding/data/datasources/local/onboarding_local_data_source.dart';
import 'package:fastnotes_bloc/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:fastnotes_bloc/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:fastnotes_bloc/features/onboarding/domain/usecases/onboarding_usecase.dart';
import 'package:fastnotes_bloc/features/splash/data/datasources/local/splash_local_data_source.dart';
import 'package:fastnotes_bloc/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:fastnotes_bloc/features/splash/domain/repositories/splash_repository.dart';
import 'package:fastnotes_bloc/features/splash/domain/usecases/splash_usecase.dart';
import 'package:get_it/get_it.dart';

// Dependency Injection
// DI için GetIt kütüphanesi kullanılıyor.
class InjectionContainer {
  static final GetIt getIt = GetIt.instance;

  // InjectionContainer'ın init fonksiyonu.
  // Bu fonksiyon, uygulama başladığında çağrılır.
  static Future<void> init() async {
    // Core - Logging
    getIt.registerSingleton<AppLogger>(AppLogger());

    // Core - Storage
    await initStorage();

    // Core - Network
    getIt.registerSingleton<AuthInterceptor>(
      AuthInterceptor(getIt<StorageService>(), getIt<AppLogger>()),
    );
    getIt.registerSingleton<ApiClient>(
      ApiClient(getIt<AuthInterceptor>(), getIt<AppLogger>()),
    );

    // Features - Onboarding
    await initOnboarding();
    // Features - Auth
    await initAuth();
    // Features - Splash
    await initSplash();
    // Features - Notes
    await initNotes();
    // Core - UseCases - GetLoggedUserUseCase
    getIt.registerSingleton<GetLoggedUserUseCase>(
      GetLoggedUserUseCase(getIt<StorageService>(), getIt<AppLogger>()),
    );
  }

  // Init Storage
  static Future<void> initStorage() async {
    getIt.registerSingleton<StorageService>(
      StorageServiceImpl(getIt<AppLogger>()),
    );
    await getIt<StorageService>().init();
  }
  // Kod okunabilirliği için feature ayrı fonksiyonlar kullanılıyor.

  // Init Splash
  static Future<void> initSplash() async {
    getIt.registerSingleton<SplashLocalDataSource>(
      SplashLocalDataSourceImpl(getIt<StorageService>()),
    );
    getIt.registerSingleton<SplashRepository>(
      SplashRepositoryImpl(getIt<SplashLocalDataSource>()),
    );
    getIt.registerFactory<SplashUseCase>(
      () => SplashUseCase(getIt<SplashRepository>()),
    );
  }

  static Future<void> initOnboarding() async {
    getIt.registerSingleton<OnboardingLocalDataSource>(
      OnboardingLocalDataSourceImpl(getIt<StorageService>()),
    );
    getIt.registerSingleton<OnboardingRepository>(
      OnboardingRepositoryImpl(getIt<OnboardingLocalDataSource>()),
    );
    getIt.registerFactory<OnboardingUseCase>(
      () => OnboardingUseCase(getIt<OnboardingRepository>()),
    );
  }

  // Init Auth
  static Future<void> initAuth() async {
    getIt.registerSingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(getIt<ApiClient>()),
    );
    getIt.registerSingleton<AuthLocalDataSource>(
      AuthLocalDataSourceImpl(getIt<StorageService>()),
    );
    // Repository
    getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(
        getIt<AuthRemoteDataSource>(),
        getIt<AuthLocalDataSource>(),
      ),
    );
    // UseCaseler
    getIt.registerFactory<AuthUseCase>(
      () => AuthUseCase(getIt<AuthRepository>()),
    );
  }

  // Features - Notes
  static Future<void> initNotes() async {
    // Remote Data Source
    getIt.registerSingleton<NoteRemoteDataSource>(
      NoteRemoteDataSourceImpl(getIt<ApiClient>()),
    );
    getIt.registerSingleton<NoteLocalDataSource>(
      NoteLocalDataSourceImpl(getIt<StorageService>()),
    );
    // Repository
    getIt.registerSingleton<NoteRepository>(
      NoteRepositoryImpl(
        getIt<NoteRemoteDataSource>(),
        getIt<NoteLocalDataSource>(),
      ),
    );
    // UseCaseler
    getIt.registerFactory<GetNotesUsecase>(
      () => GetNotesUsecase(
        getIt<NoteRepository>(),
        getIt<GetLoggedUserUseCase>(),
      ),
    );
    getIt.registerFactory<CreateNotesUsecase>(
      () => CreateNotesUsecase(getIt<NoteRepository>()),
    );
    getIt.registerFactory<DeleteNotesUsecase>(
      () => DeleteNotesUsecase(getIt<NoteRepository>()),
    );
  }
}
