import 'package:get_it/get_it.dart';
import 'package:task/core/theme/cubit/cubit/change_theme_cubit.dart';
import 'package:task/core/utiles/cubit/obscure_text_cubit.dart';
import 'package:task/features/login/presentation/cubit/login_cubit.dart';


final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerSingleton(ChangeThemeCubit());
  sl.registerSingleton(LoginCubit());
  // sl.registerSingleton(SignupCubit());
  sl.registerSingleton(ObscureTextCubit());
  
}
