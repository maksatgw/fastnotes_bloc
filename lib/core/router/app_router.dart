import 'package:fastnotes_bloc/core/router/route_names.dart';
import 'package:fastnotes_bloc/features/notes/presentation/screens/notes_list_screen.dart';
import 'package:go_router/go_router.dart';

// Uygulamadaki routing için GoRouter kullanılıyor.
class AppRouter {
  static final GoRouter router = GoRouter(
    // Başlangıçta gösterilecek sayfa
    initialLocation: RouteNames.notesList,
    routes: [
      // Notes
      GoRoute(
        path: RouteNames.notesList,
        builder: (context, state) => NotesListScreen(),
      ),
    ],
  );
}
