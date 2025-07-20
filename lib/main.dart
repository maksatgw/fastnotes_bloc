import 'package:fastnotes_bloc/core/storage/storage_service.dart';
import 'package:fastnotes_bloc/core/theme/app_theme.dart';
import 'package:fastnotes_bloc/core/utils/snackbar_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastnotes_bloc/core/dependency_injection/injection_container.dart';
import 'package:fastnotes_bloc/core/theme/theme_cubit/theme_cubit.dart';
import 'package:fastnotes_bloc/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:fastnotes_bloc/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:fastnotes_bloc/core/router/app_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // InjectionContainer ile dependency injection yapılıyor.
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await InjectionContainer.init();
  runApp(const FastNotesApp());
}

class FastNotesApp extends StatelessWidget {
  const FastNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Uygulamada birden fazla bloc kullanılıyor.
    // Bu yüzden MultiBlocProvider ile blocları oluşturuyoruz.
    // BlocProvider ile bloc'u oluşturduğumuzda, bloc'un lifecycle'ı uygulama ile aynı olur.
    return MultiBlocProvider(
      providers: [
        // ThemeCubit, uygulama temasını yönetir.
        BlocProvider(
          create: (context) =>
              ThemeCubit(InjectionContainer.getIt<StorageService>()),
        ),
        // NotesBloc, notları yönetir.
        BlocProvider(
          create: (context) => NotesBloc(
            getNotesUsecase: InjectionContainer.getIt<GetNotesUsecase>(),
          ),
        ),
      ],
      // Ana widget'ı ThemeCubit ile build ediyoruz.
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            // Routing için AppRouter kullanılıyor.
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            // ThemeCubit'ten themeMode'u alıyoruz.
            themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            // Snackbar'ları yönetmek için SnackbarUtils kullanılıyor.
            scaffoldMessengerKey: SnackbarUtils.scaffoldMessengerKey,
          );
        },
      ),
    );
  }
}
