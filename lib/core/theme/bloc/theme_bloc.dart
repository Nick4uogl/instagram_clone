import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(bool isLightTheme)
      : super(ThemeInitial(isLightTheme: isLightTheme)) {
    on<ToggleTheme>(_onToggleTheme);
  }

  Future<void> _onToggleTheme(
      ToggleTheme event, Emitter<ThemeState> emit) async {
    var newTheme = !state.isLightTheme;
    SharedPreferences.getInstance()
        .then((prefs) => prefs.setBool('isLightTheme', newTheme));
    emit(ThemeToggled(isLightTheme: newTheme));
  }
}
