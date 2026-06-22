import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task/core/theme/app_theme.dart';
import 'package:task/core/theme/cubit/cubit/change_theme_cubit.dart';
import 'package:task/core/utiles/setup_service_locator.dart';
import 'package:task/features/login/presentation/view/login_view.dart';
import 'package:task/main.dart';

class TasksApp extends StatefulWidget {
  const TasksApp({super.key});

  @override
  State<TasksApp> createState() => _TasksAppState();
}

class _TasksAppState extends State<TasksApp> {
    final cubit = sl<ChangeThemeCubit>();
  @override
  Widget build(BuildContext context) {
   return  ScreenUtilInit(
      designSize: const Size(360, 784),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocBuilder<ChangeThemeCubit, ChangeThemeState>(
          bloc: cubit,
          builder: (context, state) {
            if (state is ChangeTheme) {
              mode = state.mode;
            }
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: mode == true ? ThemeMode.dark : ThemeMode.light,
              home: child,
            );
          },
        );
      },
      child: LoginView(),
    );

  }
}