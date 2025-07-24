import 'package:fastnotes_bloc/core/storage/storage_service.dart';
import 'package:fastnotes_bloc/core/theme/app_theme.dart';
import 'package:fastnotes_bloc/core/usecases/get_logged_user_use_case.dart';
import 'package:fastnotes_bloc/core/usecases/logged_user_cubit.dart/logged_user_cubit.dart';
import 'package:fastnotes_bloc/features/auth/domain/usecases/auth_use_case.dart';
import 'package:fastnotes_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fastnotes_bloc/features/notes/domain/usecases/create_notes_usecase.dart';
import 'package:fastnotes_bloc/features/splash/domain/usecases/splash_use_case.dart';
import 'package:fastnotes_bloc/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fastnotes_bloc/core/dependency_injection/injection_container.dart';
import 'package:fastnotes_bloc/core/theme/theme_cubit/theme_cubit.dart';
import 'package:fastnotes_bloc/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:fastnotes_bloc/features/notes/domain/usecases/get_notes_usecase.dart';
import 'package:fastnotes_bloc/core/router/app_router.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // InjectionContainer ile dependency injection yapılıyor.
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await InjectionContainer.init();
  FlutterNativeSplash.remove();
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
        // SplashCubit, splash ekranını yönetir.
        BlocProvider(
          create: (context) =>
              SplashCubit(InjectionContainer.getIt<SplashUseCase>()),
        ),
        // NotesBloc, notları yönetir.
        BlocProvider(
          create: (context) => NotesBloc(
            InjectionContainer.getIt<GetNotesUsecase>(),
            InjectionContainer.getIt<CreateNotesUsecase>(),
          ),
        ),
        // AuthBloc, auth işlemlerini yönetir.
        BlocProvider(
          create: (context) =>
              AuthBloc(InjectionContainer.getIt<AuthUseCase>()),
        ),
        // LoggedUserCubit, kullanıcı bilgisini yönetir.
        BlocProvider(
          create: (context) =>
              LoggedUserCubit(InjectionContainer.getIt<GetLoggedUserUseCase>()),
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
          );
        },
      ),
    );
  }
}
