import 'package:bloc/bloc.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/note_entity.dart';
import 'package:fastnotes_bloc/features/notes/domain/usecases/create_notes_usecase.dart';
import 'package:fastnotes_bloc/features/notes/domain/usecases/get_notes_usecase.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetNotesUsecase _getNotesUsecase;
  final CreateNotesUsecase _createNotesUsecase;

  NotesBloc(this._getNotesUsecase, this._createNotesUsecase)
    : super(NotesInitial()) {
    // İlk notları yükle
    on<GetNotesEvent>(_onGetNotes);

    // Daha fazla not yükle (Infinite Scrolling)
    on<LoadMoreNotesEvent>(_onLoadMoreNotes);

    // Notları yenile (Pull to Refresh)
    on<RefreshNotesEvent>(_onRefreshNotes);

    // Not oluşturma
    on<CreateNoteEvent>(_onValidateCreateNote);

    // Bloc başlatıldığında GetNotesEvent'i tetikle
    add(GetNotesEvent());
  }

  // İlk sayfa yükleme
  Future<void> _onGetNotes(
    GetNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    // Loading state'ini göster
    emit(NotesLoadingState());
    // Notları ve kullanıcı bilgisini al
    final result = await _getNotesUsecase.getInitialNotes();

    result.fold(
      // Result, eğer exception'a düşerse, NotesErrorState'i göster
      (failure) => emit(NotesErrorState(message: failure.message)),
      (success) {
        if (success.notes.isEmpty) {
          emit(NotesEmptyState());
        } else {
          emit(
            NotesLoadedState(
              notes: success.notes,
              currentPage: 1,
              hasNext: success.hasNext,
              isLoadingMore: false,
            ),
          );
        }
      },
    );
  }

  // Infinite Scrolling - Yeni sayfa yükleme
  Future<void> _onLoadMoreNotes(
    LoadMoreNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    final currentState = state;

    // Sadece NotesLoaded state'inde ve hasNext true ise yeni sayfa yükle
    if (currentState is NotesLoadedState &&
        currentState.hasNext &&
        !currentState.isLoadingMore) {
      // Loading state'ini göster
      // Copywith ile aynı nesneyi fieldları aynı tutuyoruz ve isLoadingMore'ı true yapıyoruz.
      emit(currentState.copyWith(isLoadingMore: true));

      // Bir sonraki sayfayı yükle
      final nextPage = currentState.currentPage + 1;
      final result = await _getNotesUsecase.getNotesForPage(nextPage);

      result.fold(
        (failure) => emit(NotesErrorState(message: failure.message)),
        (success) {
          if (success.notes.isEmpty) {
            emit(NotesEmptyState());
          } else {
            // Mevcut notlarla yeni gelen notları birleştir
            currentState.notes?.addAll(success.notes);

            emit(
              NotesLoadedState(
                notes: currentState.notes,
                currentPage: nextPage,
                hasNext: success.hasNext,
                isLoadingMore: false,
              ),
            );
          }
        },
      );
    }
  }

  // Yenileme İşlemi
  Future<void> _onRefreshNotes(
    RefreshNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesRefreshingState());
    final result = await _getNotesUsecase.getInitialNotes();

    result.fold(
      (failure) => emit(NotesErrorState(message: failure.message)),
      (success) {
        if (success.notes.isEmpty) {
          emit(NotesEmptyState());
        } else {
          emit(
            NotesLoadedState(
              notes: success.notes,
              currentPage: 1,
              hasNext: success.hasNext,
              isLoadingMore: false,
            ),
          );
        }
      },
    );
  }

  Future<void> _onValidateCreateNote(
    CreateNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    final validationResult = _createNotesUsecase.validateNote(event.note);
    await validationResult.fold(
      (failure) async {
        emit(ValidationState(message: failure.message));
      },
      (success) async {
        await _onCreateNote(event, emit);
      },
    );
  }

  Future<void> _onCreateNote(
    CreateNoteEvent event,
    Emitter<NotesState> emit,
  ) async {
    emit(NotesCreatingState());

    final result = await _createNotesUsecase.createNote(event.note);
    result.fold(
      (failure) => emit(NotesErrorState(message: failure.message)),
      (success) => emit(NotesCreatedState()),
    );
  }
}
