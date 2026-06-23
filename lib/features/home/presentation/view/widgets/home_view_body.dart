import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task/core/utiles/app_fonts.dart';
import 'package:task/core/utiles/extentions.dart';
import 'package:task/core/utiles/routes/router_named.dart';
import 'package:task/core/utiles/setup_service_locator.dart';
import 'package:task/core/utiles/widgets/1.2%20loading_shimmer.dart';
import 'package:task/features/home/domain/entites/posts_entite.dart';
import 'package:task/features/home/presentation/cubit/cubit/get_users_cubit.dart';
import 'package:task/features/home/presentation/view/widgets/post_container.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late GetUsersCubit usersCubit;

  @override
  void initState() {
    usersCubit = sl<GetUsersCubit>();
    usersCubit.feachPosts();
    super.initState();
  }

  @override
  void dispose() {
    usersCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => context.push(RouterNamed.profile),
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                    radius: 25.r,
                  ).withPadding(end: 8.w),
                ),
                Text(
                  Supabase
                          .instance
                          .client
                          .auth
                          .currentUser
                          ?.userMetadata?['username'] ??
                      '',
                  style: AppFonts.f16Redular717786().copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ).withPadding(horizontal: 12.w, vertical: 12.h),
            Expanded(
              child: BlocBuilder<GetUsersCubit, GetUsersState>(
                bloc: usersCubit,
                builder: (context, state) {
                  if (state is GetUsersFailure) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.errorMessage,
                          style: AppFonts.f16Redular717786().copyWith(
                            color: Colors.red,
                          ),
                        ).center,
                        IconButton(
                          onPressed: () => usersCubit.feachPosts(),
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.blue,
                            size: 20.h,
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is GetUsersSuccess) {
                    if (state.posts.isEmpty) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'No Data To Display',
                            style: AppFonts.f16Redular717786().copyWith(
                              color: Colors.red,
                            ),
                          ).center,
                          IconButton(
                            onPressed: () => usersCubit.feachPosts(),
                            icon: Icon(
                              Icons.refresh,
                              color: Colors.blue,
                              size: 20.h,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return RefreshIndicator(
                        color: Colors.blue,
                        onRefresh: () => usersCubit.feachPosts(),
                        child: ListView.builder(
                          itemCount: state.posts.length,
                          itemBuilder: (context, index) {
                            PostsModel postsModel = state.posts[index];
                            return GestureDetector(
                              onTap: () => context.push(RouterNamed.details,extra: postsModel),
                              child: PostContainer(
                                postsModel: postsModel,
                                isDetailes: false,
                              ),
                            );
                          },
                        ),
                      );
                    }
                  }
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return LoadingShimmer(
                        width: double.infinity,
                        height: 200.h,
                      ).withPadding(vertical: 5.h, horizontal: 12.w);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
