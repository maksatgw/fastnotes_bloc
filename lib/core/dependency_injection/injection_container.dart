import 'package:fastnotes_bloc/core/network/api_client.dart';
import 'package:fastnotes_bloc/core/storage/storage_service.dart';
import 'package:fastnotes_bloc/core/usecases/get_logged_user_use_case.dart';
import 'package:fastnotes_bloc/features/auth/data/datasources/remote/auth_remote_data_source.dart';
import 'package:fastnotes_bloc/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:fastnotes_bloc/features/auth/domain/repositories/auth_repository.dart';
import 'package:fastnotes_bloc/features/auth/domain/usecases/auth_use_case.dart';
import 'package:fastnotes_bloc/features/notes/data/datasources/remote/note_remote_data_source.dart';
import 'package:fastnotes_bloc/features/notes/data/repositories/note_repository_impl.dart';
import 'package:fastnotes_bloc/features/notes/domain/repositories/note_repository.dart';
import 'package:fastnotes_bloc/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:get_it/get_it.dart';

// Dependency Injection
// DI için GetIt kütüphanesi kullanılıyor.
class InjectionContainer {
  static final GetIt getIt = GetIt.instance;

  // InjectionContainer'ın init fonksiyonu.
  // Bu fonksiyon, uygulama başladığında çağrılır.
  static Future<void> init() async {
    // Core - Storage
    getIt.registerSingleton<StorageService>(StorageServiceImpl());
    await getIt<StorageService>().init();

    // Core - Network
    getIt.registerSingleton<ApiClient>(ApiClient());
    await initAuth();
    await initNotes();
    getIt.registerSingleton<GetLoggedUserUseCase>(
      GetLoggedUserUseCase(getIt<StorageService>()),
    );
  }

  static Future<void> initAuth() async {
    getIt.registerSingleton<AuthRemoteDataSource>(
      AuthRemoteDataSourceImpl(getIt<ApiClient>()),
    );
    // Repository
    getIt.registerSingleton<AuthRepository>(
      AuthRepositoryImpl(
        getIt<AuthRemoteDataSource>(),
        getIt<StorageService>(),
      ),
    );
    // UseCaseler
    getIt.registerFactory<AuthUseCase>(
      () => AuthUseCase(getIt<AuthRepository>()),
    );
  }

  // Kod okunabilirliği için feature ayrı fonksiyonlar kullanılıyor.
  // Features - Notes
  static Future<void> initNotes() async {
    // Remote Data Source
    getIt.registerSingleton<NoteRemoteDataSource>(
      NoteRemoteDataSourceImpl(getIt<ApiClient>()),
    );
    // Repository
    getIt.registerSingleton<NoteRepository>(
      NoteRepositoryImpl(getIt<NoteRemoteDataSource>()),
    );
    // UseCaseler
    getIt.registerFactory<GetNotesUsecase>(
      () => GetNotesUsecase(
        getIt<NoteRepository>(),
        getIt<GetLoggedUserUseCase>(),
      ),
    );
  }
}
