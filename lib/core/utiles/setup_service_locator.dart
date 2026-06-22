import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/theme/cubit/cubit/change_theme_cubit.dart';
import 'package:task/core/utiles/cubit/obscure_text_cubit.dart';
import 'package:task/features/auth/cubit/start_cool_down_cubit.dart';
import 'package:task/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:task/features/auth/sign_up/presentation/cubit/sign_up_cubit.dart';


final sl = GetIt.instance;

void setupServiceLocator() {

  sl.registerFactory(()=>ChangeThemeCubit());
  sl.registerFactory(()=>LoginCubit());
  sl.registerLazySingleton<SupabaseClient>(
    () => Supabase.instance.client,
  ); 
   sl.registerFactory(()=> SignUpCubit());
  sl.registerFactory(()=>ObscureTextCubit());
  
sl.registerLazySingleton<StartCoolDownCubit>(
  () => StartCoolDownCubit(),
);  
}
