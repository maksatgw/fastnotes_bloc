import 'package:fastnotes_bloc/core/theme/theme_cubit/theme_cubit.dart';
import 'package:fastnotes_bloc/core/utils/date_utils.dart';
import 'package:fastnotes_bloc/core/utils/snackbar_utils.dart';
import 'package:fastnotes_bloc/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 100) {
        context.read<NotesBloc>().add(LoadMoreNotesEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          BlocSelector<ThemeCubit, ThemeState, ThemeMode>(
            selector: (state) => state.themeMode,
            builder: (context, themeMode) {
              return IconButton(
                onPressed: () => context.read<ThemeCubit>().toggleTheme(),
                icon: themeMode == ThemeMode.light
                    ? const Icon(Icons.dark_mode)
                    : const Icon(Icons.light_mode),
              );
            },
          ),
        ],
      ),
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
                        return ListTile(
                          title: Text(note?.title ?? ''),
                          subtitle: Text(note?.content ?? ''),
                          trailing: Text(
                            DateFormatUtils.formatDate(
                              note?.createdAt ?? DateTime.now(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
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
          // Diğer durumlarda boş bırak
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
