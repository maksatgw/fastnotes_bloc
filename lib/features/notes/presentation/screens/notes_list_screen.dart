import 'package:fastnotes_bloc/core/constants/asset_constants.dart';
import 'package:fastnotes_bloc/core/router/app_router.dart';
import 'package:fastnotes_bloc/core/theme/theme_cubit/theme_cubit.dart';
import 'package:fastnotes_bloc/core/router/route_names.dart';
import 'package:fastnotes_bloc/core/usecases/logged_user_cubit.dart/logged_user_cubit.dart';
import 'package:fastnotes_bloc/core/utils/snackbar_utils.dart';
import 'package:fastnotes_bloc/core/widgets/change_theme_button_widget.dart';
import 'package:fastnotes_bloc/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:fastnotes_bloc/features/notes/presentation/widgets/note_tile_widget.dart';
import 'package:fastnotes_bloc/features/notes/presentation/widgets/user_drawer_widget.dart';
import 'package:fastnotes_bloc/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> with RouteAware {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Drawer için kullanıcı bilgisini al.
    context.read<LoggedUserCubit>().getLoggedUser();
    // Sayfanın sonunda olup olmadığını kontrol et.
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        // Sayfanın sonunda ise daha fazla not yükle.
        context.read<NotesBloc>().add(LoadMoreNotesEvent());
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // RouteObserver'ı subscribe ediyoruz.
    AppRouter.routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    super.dispose();
    // Scroll controller'ı dispose ediyoruz.
    _scrollController.dispose();
    // RouteObserver'ı unsubscribe ediyoruz.
    AppRouter.routeObserver.unsubscribe(this);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    // Bir önceki sayfadan geri gelindiğinde notları yükle.
    context.read<NotesBloc>().add(GetNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: GlobalSnackBarUtil.scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notes'),
          actions: [
            _buildThemeSelectorButton(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(RouteNames.notesCreate);
          },
          child: const Icon(Icons.add),
        ),
        drawer: _buildDrawer(),
        body: BlocConsumer<NotesBloc, NotesState>(
          listener: (context, state) {
            // Hata durumunda snackbar göster
            if (state is NotesErrorState) {
              GlobalSnackBarUtil.showErrorSnackbar(state.message);
            }
          },
          builder: (context, state) {
            // Loading durumunda loading indicator göster
            if (state is NotesLoadingState) {
              return _buildLoadingState();
            }
            // Loaded durumunda liste göster
            if (state is NotesLoadedState) {
              return _buildLoadedState(context, state);
            }
            // Hata durumunda hata mesajı ve tekrar dene butonu göster
            if (state is NotesErrorState) {
              return _buildErrorState(state, context);
            }

            // Empty durumunda boş bırak
            if (state is NotesEmptyState) {
              return _buildEmptyState();
            }

            // Diğer durumlarda boş bırak
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  BlocSelector<ThemeCubit, ThemeState, ThemeMode> _buildThemeSelectorButton() {
    return BlocSelector<ThemeCubit, ThemeState, ThemeMode>(
      selector: (state) {
        return state.isDarkMode ? ThemeMode.dark : ThemeMode.light;
      },
      builder: (context, state) {
        return ChangeThemeButtonWidget(
          onPressed: () {
            context.read<ThemeCubit>().toggleTheme();
          },
          themeMode: state,
        );
      },
    );
  }

  Center _buildLoadingState() =>
      const Center(child: CircularProgressIndicator());

  Center _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(AssetConstants.splashAnimation),
          Text('Not bulunamadı'),
        ],
      ),
    );
  }

  Center _buildErrorState(NotesErrorState state, BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hata: ${state.message}'),
          ElevatedButton(
            onPressed: () {
              context.read<NotesBloc>().add(GetNotesEvent());
            },
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  RefreshIndicator _buildLoadedState(
    BuildContext context,
    NotesLoadedState state,
  ) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<NotesBloc>().add(RefreshNotesEvent());
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              // Scroll controller ekleniyor
              controller: _scrollController,
              itemCount: state.notes?.length ?? 0,
              itemBuilder: (context, index) {
                final note = state.notes?[index];
                // Son item ise ve hasNext true ise loading indicator göster
                return NoteTileWidget(note: note);
              },
            ),
          ),
          // Sayfalama esnasında ekranın altında loading indicator göster.
          if (state.isLoadingMore)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: _buildLoadingState(),
            ),
        ],
      ),
    );
  }

  BlocBuilder<LoggedUserCubit, LoggedUserState> _buildDrawer() {
    return BlocBuilder<LoggedUserCubit, LoggedUserState>(
      builder: (context, state) {
        if (state is UserLoaded) {
          return UserDrawerWidget(
            onLogout: () {
              context.read<AuthBloc>().add(LogoutEvent());
            },
            photoUrl: state.user.photoUrl,
            displayName: state.user.displayName,
            email: state.user.email,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
