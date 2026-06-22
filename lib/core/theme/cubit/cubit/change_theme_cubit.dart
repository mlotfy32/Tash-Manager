import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/core/utiles/shared_pref/prefs_Keys.dart';
import 'package:task/core/utiles/shared_pref/shared_pref.dart';
import 'package:task/main.dart';

part 'change_theme_state.dart';

class ChangeThemeCubit extends Cubit<ChangeThemeState> {
  ChangeThemeCubit() : super(ChangeThemeInitial());
  void changeTheme(){
    SharedPref.instance.setBool(PrefsKeys.isDarkMode, !mode);
    emit(ChangeTheme(mode:!mode));
  }
}
