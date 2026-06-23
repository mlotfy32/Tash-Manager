import 'package:go_router/go_router.dart';
import 'package:task/core/utiles/shared_pref/prefs_Keys.dart';
import 'package:task/core/utiles/shared_pref/shared_pref.dart';
import 'package:task/features/auth/login/presentation/view/login_view.dart';
import 'package:task/features/auth/sign_up/presentation/view/sign_up_view.dart';
import 'package:task/features/detailes/view/detailes_view.dart';
import 'package:task/features/home/domain/entites/posts_entite.dart';
import 'package:task/features/home/presentation/view/home_view.dart';
import 'package:task/features/profile/presentation/view/profile_view_body.dart';

final GoRouter router = GoRouter(
  initialLocation: SharedPref.instance.getString(PrefsKeys.userID) == null
      ? '/login'
      : '/home',

  routes: [
    GoRoute(path: '/login', builder: (context, state) => LoginView()),
    GoRoute(path: '/signUp', builder: (context, state) => SignUpView()),

    GoRoute(path: '/home', builder: (context, state) => HomeView()),

    GoRoute(
      path: '/details',
      builder: (context, state) {
        var post = state.extra as PostsModel; 
        return DetailesView(postsModel: post);
      },
    ),
    GoRoute(path: '/profile', builder: (context, state) => ProfileViewBody()),
  ],
);
