import 'package:fastnotes_bloc/core/router/route_names.dart';
import 'package:fastnotes_bloc/features/auth/presentation/screens/auth_screen.dart';
import 'package:fastnotes_bloc/features/notes/presentation/screens/notes_create_screen.dart';
import 'package:fastnotes_bloc/features/notes/presentation/screens/notes_list_screen.dart';
import 'package:fastnotes_bloc/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Uygulamadaki routing için GoRouter kullanılıyor.
class AppRouter {
  // RouteObserver, sayfa geçişlerini takip eder.
  // Bu sayede, default aksiyonları takip edebiliriz.
  // Örneğin, bir sayfadan geri gelindiğinde, bir event tetikleyebiliriz.
  static final RouteObserver<ModalRoute<void>> routeObserver =
      RouteObserver<ModalRoute<void>>();

  static final GoRouter router = GoRouter(
    // Başlangıçta gösterilecek sayfa
    initialLocation: RouteNames.splash,
    observers: [routeObserver],

    routes: [
      // Auth
      GoRoute(path: RouteNames.auth, builder: (context, state) => AuthScreen()),

      // Splash
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => SplashScreen(),
      ),
      // Notes
      GoRoute(
        path: RouteNames.notesList,
        builder: (context, state) => NotesListScreen(),
      ),
      GoRoute(
        path: RouteNames.notesCreate,
        builder: (context, state) => NotesCreateScreen(),
      ),
    ],
  );
}
