import 'package:fastnotes_bloc/core/constants/asset_constants.dart';
import 'package:fastnotes_bloc/core/router/app_router.dart';
import 'package:fastnotes_bloc/core/router/route_names.dart';
import 'package:fastnotes_bloc/core/usecases/logged_user_cubit.dart/logged_user_cubit.dart';
import 'package:fastnotes_bloc/core/utils/date_utils.dart';
import 'package:fastnotes_bloc/core/utils/snackbar_utils.dart';
import 'package:fastnotes_bloc/core/widgets/change_theme_button_widget.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/note_entity.dart';
import 'package:fastnotes_bloc/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:fastnotes_bloc/features/notes/presentation/widgets/user_drawer_widget.dart';
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
  void didPush() {
    super.didPush();
    // Yeni sayfa açıldığında notları yükle.
    context.read<NotesBloc>().add(GetNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [ChangeThemeButtonWidget()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(RouteNames.notesCreate);
        },
        child: const Icon(Icons.add),
      ),
      drawer: UserDrawerWidget(),
      body: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) {
          // Hata durumunda snackbar göster
          if (state is NotesErrorState) {
            SnackbarUtils.showErrorSnackbar(state.message);
          }
        },
        builder: (context, state) {
          // Loading durumunda loading indicator göster
          if (state is NotesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          // Loaded durumunda liste göster
          if (state is NotesLoadedState) {
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
                        return _noteTileWidget(note);
                      },
                    ),
                  ),
                  // Sayfalama esnasında ekranın altında loading indicator göster.
                  if (state.isLoadingMore)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                ],
              ),
            );
          }
          // Hata durumunda hata mesajı ve tekrar dene butonu göster
          if (state is NotesErrorState) {
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

          // Empty durumunda boş bırak
          if (state is NotesEmptyState) {
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

          // Diğer durumlarda boş bırak
          return const SizedBox.shrink();
        },
      ),
    );
  }

  ListTile _noteTileWidget(NoteEntity? note) {
    return ListTile(
      title: Text(note?.title ?? ''),
      subtitle: Text(note?.content ?? ''),
      trailing: Text(
        DateFormatUtils.formatDate(note?.createdAt ?? DateTime.now()),
      ),
    );
  }
}
