import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/theme/cubit/cubit/change_theme_cubit.dart';
import 'package:task/core/utiles/bloc/bloc_observer.dart';
import 'package:task/core/utiles/setup_service_locator.dart';
import 'package:task/core/utiles/shared_pref/prefs_Keys.dart';
import 'package:task/core/utiles/shared_pref/shared_pref.dart';
import 'package:task/features/home/domain/entites/posts_entite.dart';
import 'package:task/taska_app.dart';

late bool mode;
late ChangeThemeCubit changeThemeCubit;
void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
    await dotenv.load(fileName: ".env");
    await SharedPref.init();
  String supaBaseUrl = dotenv.get('SUPABASE_URL');
  String supaBaseKey = dotenv.get('SUPABASE_ANONKEY');
  await Supabase.initialize(url: supaBaseUrl, anonKey: supaBaseKey);
  setupServiceLocator();
  mode = SharedPref.instance.getBool(PrefsKeys.isDarkMode) ?? false;
  Bloc.observer = AppBlocObserver();
  await Hive.initFlutter();
  changeThemeCubit= sl<ChangeThemeCubit>();
  Hive.registerAdapter(PostsModelAdapter());
  await Hive.openBox<PostsModel>('postsBox');
    runApp(const TasksApp());
}
