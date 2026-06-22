part of 'change_theme_cubit.dart';

@immutable
sealed class ChangeThemeState {}

final class ChangeThemeInitial extends ChangeThemeState {}
final class ChangeTheme extends ChangeThemeState {
  final bool mode;

  ChangeTheme({required this.mode});
}
