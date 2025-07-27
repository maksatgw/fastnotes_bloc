import 'package:bloc/bloc.dart';
import 'package:fastnotes_bloc/core/logging/app_logger.dart';
import 'package:fastnotes_bloc/core/storage/storage_service.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final StorageService _storageService;
  final AppLogger _appLogger;

  // State'in ilk durumunu Storage'dan alıyoruz.
  ThemeCubit(this._storageService, this._appLogger)
    : super(ThemeState(isDarkMode: _storageService.getBoolSync('isDarkMode')));

  // Theme'i değiştirmek için fonksiyon
  Future<void> toggleTheme() async {
    final newIsDarkMode = !state.isDarkMode;
    _appLogger.debug('Theme changed to $newIsDarkMode');
    await _storageService.setBool('isDarkMode', newIsDarkMode);
    emit(ThemeState(isDarkMode: newIsDarkMode));
  }
}
