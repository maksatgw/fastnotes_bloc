import 'package:fastnotes_bloc/core/network/api_client.dart';
import 'package:fastnotes_bloc/core/storage/storage_service.dart';
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
    await initNotes();
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
      () => GetNotesUsecase(getIt<NoteRepository>()),
    );
  }
}
