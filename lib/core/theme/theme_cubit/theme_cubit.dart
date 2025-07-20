import 'package:bloc/bloc.dart';
import 'package:fastnotes_bloc/core/storage/storage_service.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final StorageService _storageService;

  // State'in ilk durumunu Storage'dan alıyoruz.
  ThemeCubit(this._storageService)
    : super(ThemeState(isDarkMode: _storageService.getBoolSync('isDarkMode')));

  // Theme'i değiştirmek için fonksiyon
  Future<void> toggleTheme() async {
    final newIsDarkMode = !state.isDarkMode;
    await _storageService.setBool('isDarkMode', newIsDarkMode);
    emit(ThemeState(isDarkMode: newIsDarkMode));
  }
}
