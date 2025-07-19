part of 'notes_bloc.dart';

sealed class NotesState {}

final class NotesInitial extends NotesState {}

final class NotesLoadingState extends NotesState {}

final class NotesLoadedState extends NotesState {
  final List<NoteEntity>? notes;
  final int currentPage;
  final bool hasNext;
  final bool isLoadingMore;

  NotesLoadedState copyWith({
    List<NoteEntity>? notes,
    int? currentPage,
    bool? hasNext,
    bool? isLoadingMore,
  }) {
    return NotesLoadedState(
      notes: notes ?? this.notes,
      currentPage: currentPage ?? this.currentPage,
      hasNext: hasNext ?? this.hasNext,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  NotesLoadedState({
    required this.notes,
    required this.currentPage,
    required this.hasNext,
    required this.isLoadingMore,
  });
}

final class NotesErrorState extends NotesState {
  final String message;

  NotesErrorState({required this.message});
}

final class NotesRefreshingState extends NotesState {}
