part of 'notes_bloc.dart';

sealed class NotesEvent {}

final class GetNotesEvent extends NotesEvent {}

final class LoadMoreNotesEvent extends NotesEvent {}

final class RefreshNotesEvent extends NotesEvent {}

final class CreateNoteEvent extends NotesEvent {
  final NoteEntity note;

  CreateNoteEvent({required this.note});
}
