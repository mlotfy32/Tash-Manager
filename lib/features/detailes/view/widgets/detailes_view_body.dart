import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task/core/utiles/app_fonts.dart';
import 'package:task/core/utiles/extentions.dart';
import 'package:task/core/utiles/setup_service_locator.dart';
import 'package:task/core/utiles/widgets/1.2%20loading_shimmer.dart';
import 'package:task/features/detailes/cubit/get_tasks/get_tasks_cubit.dart';
import 'package:task/features/detailes/view/widgets/add_task_sheet.dart';
import 'package:task/features/home/domain/entites/posts_entite.dart';
import 'package:task/features/home/presentation/view/widgets/post_container.dart';

class DetailesViewBody extends StatefulWidget {
  const DetailesViewBody({super.key, required this.postsModel});
  final PostsModel postsModel;

  @override
  State<DetailesViewBody> createState() => _DetailesViewBodyState();
}

class _DetailesViewBodyState extends State<DetailesViewBody> {
  late GetTasksCubit getTasks;
  @override
  void initState() {
    getTasks = sl<GetTasksCubit>();
    getTasks.getTasks(userId: widget.postsModel.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text(
              'Task Detailes',
              style: AppFonts.f20ExtraBold0F172A().copyWith(
                color: context.theme.primaryColor,
              ),
            ).center.withPadding(vertical: 10.h),
            Expanded(
              child: BlocBuilder<GetTasksCubit, GetTasksState>(
                bloc: getTasks,
                builder: (context, state) {
                  if (state is GetTasksFailure) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.errorMessage,
                          style: AppFonts.f16Redular717786().copyWith(
                            color: Colors.red,
                          ),textAlign: TextAlign.center,
                        ).center,
                        IconButton(
                          onPressed: () => getTasks.getTasks(
                            userId: widget.postsModel.userId,
                          ),
                          icon: Icon(
                            Icons.refresh,
                            color: Colors.blue,
                            size: 20.h,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return ListView.builder(
                      itemCount: state is GetTasksSuccess
                          ? state.posts.length
                          : 10,
                      itemBuilder: (context, index) => state is GetTasksSuccess
                          ? state.posts.isEmpty
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'No Data To Display',
                                        style: AppFonts.f16Redular717786()
                                            .copyWith(color: Colors.red),
                                      ).center,
                                      IconButton(
                                        onPressed: () => getTasks.getTasks(
                                          userId: widget.postsModel.userId,
                                        ),
                                        icon: Icon(
                                          Icons.refresh,
                                          color: Colors.blue,
                                          size: 20.h,
                                        ),
                                      ),
                                    ],
                                  )
                                : RefreshIndicator(
                                    onRefresh: () => getTasks.getTasks(
                                      userId: widget.postsModel.userId,
                                    ),
                                    child: PostContainer(tasksCubit: getTasks,
                                      postsModel: state.posts[index],
                                      isDetailes: true,
                                    ),
                                  )
                          : LoadingShimmer(
                              width: double.infinity,
                              height: 200.h,
                            ).withPadding(horizontal: 12.w),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => Get.bottomSheet(AddTaskSheet(),isDismissible: true,isScrollControlled: true),
        child: Icon(Icons.add, color: Colors.white, size: 20.h),
      ),
    );
  }
}
