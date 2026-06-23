import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/theme/cubit/cubit/change_theme_cubit.dart';
import 'package:task/core/utiles/cubit/obscure_text_cubit.dart';
import 'package:task/core/utiles/services/api_services/api_services.dart';
import 'package:task/features/auth/cubit/start_cool_down_cubit.dart';
import 'package:task/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:task/features/auth/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:task/features/detailes/cubit/add_task/add_task_cubit.dart';
import 'package:task/features/detailes/cubit/get_tasks/get_tasks_cubit.dart';
import 'package:task/features/detailes/cubit/update_task/update_task_cubit.dart';
import 'package:task/features/home/data/data_source/home_local_data_source.dart';
import 'package:task/features/home/data/data_source/home_remote_data_source.dart';
import 'package:task/features/home/data/rebos/home_rebo_imp.dart';
import 'package:task/features/home/domain/rebos/home_repo.dart';
import 'package:task/features/home/domain/use_case/featch_users_usecase.dart';
import 'package:task/features/home/presentation/cubit/cubit/get_users_cubit.dart';

final sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerFactory(() => ChangeThemeCubit());
  sl.registerFactory(() => LoginCubit());
  sl.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  sl.registerFactory(() => SignUpCubit());
  sl.registerFactory(() => ObscureTextCubit());

  sl.registerLazySingleton<StartCoolDownCubit>(() => StartCoolDownCubit());
  sl.registerSingleton<ApiService>(ApiService.instance);

  sl.registerSingleton<HomeRebo>(
    HomeReboImp(
      homeLocalDataSource: HomeLocalDataSourceImpl(),
      homeRemoteDataSource: HomeRemoteDataSourceImpl(
        apiservice: sl.get<ApiService>(),
      ),
    ),
  );
  sl.registerSingleton<FeatchUsersUsecase>(
    FeatchUsersUsecase(homeRebo: sl.get<HomeRebo>()),
  );
  sl.registerFactory(
    () => GetUsersCubit(useCase: sl.get<FeatchUsersUsecase>()),
  );
  sl.registerFactory(() => GetTasksCubit());
  sl.registerFactory(() => AddTaskCubit());
  sl.registerFactory(() => UpdateTaskCubit());
}
