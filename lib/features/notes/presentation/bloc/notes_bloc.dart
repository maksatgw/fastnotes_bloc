import 'package:bloc/bloc.dart';
import 'package:fastnotes_bloc/features/notes/domain/entities/note_entity.dart';
import 'package:fastnotes_bloc/features/notes/domain/usecases/get_notes_usecase.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetNotesUsecase _getNotesUsecase;

  NotesBloc(this._getNotesUsecase) : super(NotesInitial()) {
    // İlk notları yükle
    on<GetNotesEvent>(_onGetNotes);

    // Daha fazla not yükle (Infinite Scrolling)
    on<LoadMoreNotesEvent>(_onLoadMoreNotes);

    // Notları yenile (Pull to Refresh)
    on<RefreshNotesEvent>(_onRefreshNotes);

    // Bloc başlatıldığında GetNotesEvent'i tetikle
    add(GetNotesEvent());
  }

  // İlk sayfa yükleme
  Future<void> _onGetNotes(
    GetNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    try {
      // Loading state'ini göster
      emit(NotesLoadingState());
      // Notları ve kullanıcı bilgisini al
      final result = await _getNotesUsecase.getInitialNotes();

      // Eğer notlar varsa, NotesLoadedState'i göster
      if (result != null) {
        emit(
          NotesLoadedState(
            notes: result.notes,
            currentPage: 1,
            hasNext: result.hasNext,
            isLoadingMore: false,
          ),
        );
      } else {
        // Eğer Notlar yoksa, boş liste gönder.
        emit(NotesEmptyState());
      }
    } catch (e) {
      emit(NotesErrorState(message: e.toString()));
    }
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
      try {
        // Loading state'ini göster
        emit(currentState.copyWith(isLoadingMore: true));

        // Bir sonraki sayfayı yükle
        final nextPage = currentState.currentPage + 1;
        final result = await _getNotesUsecase.getNotesForPage(nextPage);
        if (result != null) {
          // Mevcut notlarla yeni gelen notları birleştir
          currentState.notes?.addAll(result.notes);

          emit(
            NotesLoadedState(
              notes: currentState.notes,
              currentPage: nextPage,
              hasNext: result.hasNext,
              isLoadingMore: false,
            ),
          );
        } else {
          // Hata durumunda loading state'ini kapat
          emit(currentState.copyWith(isLoadingMore: false));
        }
      } catch (e) {
        // Hata durumunda loading state'ini kapat ve hata göster
        emit(currentState.copyWith(isLoadingMore: false));
        emit(NotesErrorState(message: e.toString()));
      }
    }
  }

  // Yenileme İşlemi
  Future<void> _onRefreshNotes(
    RefreshNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    try {
      emit(NotesRefreshingState());
      final result = await _getNotesUsecase.getInitialNotes();
      if (result != null) {
        emit(
          NotesLoadedState(
            notes: result.notes,
            currentPage: 1,
            hasNext: result.hasNext,
            isLoadingMore: false,
          ),
        );
      } else {
        emit(NotesEmptyState());
      }
    } catch (e) {
      emit(NotesErrorState(message: e.toString()));
    }
  }
}
