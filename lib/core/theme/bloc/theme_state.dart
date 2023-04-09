part of 'theme_bloc.dart';

abstract class ThemeState {
  ThemeState({this.isLightTheme = true});
  bool isLightTheme;
}

class ThemeInitial extends ThemeState {
  ThemeInitial({super.isLightTheme});
}

class ThemeToggled extends ThemeState {
  ThemeToggled({super.isLightTheme});
}
