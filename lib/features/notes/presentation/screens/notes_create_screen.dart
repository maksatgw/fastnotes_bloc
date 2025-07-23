import 'package:fastnotes_bloc/core/utils/snackbar_utils.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/note_entity.dart';
import 'package:fastnotes_bloc/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:fastnotes_bloc/features/notes/presentation/widgets/note_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotesCreateScreen extends StatefulWidget {
  const NotesCreateScreen({super.key});

  @override
  State<NotesCreateScreen> createState() => _NotesCreateScreenState();
}

class _NotesCreateScreenState extends State<NotesCreateScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Not Oluştur'),
        actions: [
          _addButton(context),
        ],
      ),
      body: BlocListener<NotesBloc, NotesState>(
        listener: (context, state) {
          if (state is NotesErrorState) {
            SnackbarUtils.showErrorSnackbar(state.message);
            context.pop();
          }
          if (state is ValidationState) {
            SnackbarUtils.showErrorSnackbar(state.message);
          }
          if (state is NotesCreatedState) {
            SnackbarUtils.showSuccessSnackbar('Not başarıyla oluşturuldu');
            context.read<NotesBloc>().add(GetNotesEvent());
            context.pop();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              NoteTextFieldWidget(
                titleController: _titleController,
                hintText: 'Not başlığını giriniz',
                maxLines: 1,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: NoteTextFieldWidget(
                  titleController: _contentController,
                  hintText: 'Not İçeriği',
                  maxLines: 20,
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextButton _addButton(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<NotesBloc>().add(
          CreateNoteEvent(
            note: NoteEntity(
              title: _titleController.text,
              content: _contentController.text,
            ),
          ),
        );
      },
      child: const Text('Kaydet'),
    );
  }
}
