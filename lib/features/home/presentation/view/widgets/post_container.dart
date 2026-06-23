import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:task/core/utiles/app_fonts.dart';
import 'package:task/core/utiles/extentions.dart';
import 'package:task/core/utiles/setup_service_locator.dart';
import 'package:task/features/detailes/cubit/get_tasks/get_tasks_cubit.dart';
import 'package:task/features/detailes/cubit/update_task/update_task_cubit.dart';
import 'package:task/features/home/domain/entites/posts_entite.dart';

class PostContainer extends StatefulWidget {
  const PostContainer({
    super.key,
    required this.postsModel,
    required this.isDetailes,
    this.tasksCubit,
  });
  final PostsModel postsModel;
  final bool isDetailes;
  final GetTasksCubit? tasksCubit;
  @override
  State<PostContainer> createState() => _PostContainerState();
}

class _PostContainerState extends State<PostContainer> {
  late UpdateTaskCubit updateTaskCubit;
  @override
  void initState() {
    updateTaskCubit = sl<UpdateTaskCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.theme.primaryColor.withAlpha(80),
            blurStyle: BlurStyle.outer,
            blurRadius: 5,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5.h),
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: widget.postsModel.completed
                  ? Colors.blue
                  : Colors.blueGrey,
            ),
            child: Text(
              widget.postsModel.completed ? 'Completed' : 'In Progress',
              style: AppFonts.f14Redular414755().copyWith(
                color: Colors.white,
                fontSize: 12.sp,
              ),
            ),
          ).toStart,
          Text(
            'Title: ${widget.postsModel.title}',
            style: AppFonts.f14Redular414755().copyWith(
              color: context.theme.primaryColor,
            ),
            maxLines: widget.isDetailes ? 3 : 1,
            overflow: TextOverflow.ellipsis,
          ).toStart.withPadding(bottom: 5.h),
          Text(
            'Body: ${widget.postsModel.body}',
            style: AppFonts.f14Redular414755().copyWith(fontSize: 12.sp),
            maxLines: widget.isDetailes ? 5 : 3,
          ).toStart,
          widget.isDetailes
              ? BlocConsumer<UpdateTaskCubit, UpdateTaskState>(
                  bloc: updateTaskCubit,
                  listener: (context, state) {
                    if (state is UpdateTaskSuccess) {
                      widget.tasksCubit!.getTasks(
                        userId: widget.postsModel.userId,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        Text(
                          'Is Completed',
                          style: AppFonts.f14Redular414755().copyWith(
                            color: context.theme.primaryColor,
                          ),
                        ),
                        state is UpdateTaskLoading
                            ? SizedBox(
                                width: 25.h,
                                height: 25.h,
                                child: CircularProgressIndicator(strokeWidth: 5,),
                              ).withPadding(horizontal: 10.w,vertical: 12.h)
                            : Checkbox(
                                value: widget.postsModel.completed,
                                onChanged: (value) {
                                  updateTaskCubit.updateTaskStatus(
                                    id: widget.postsModel.id,
                                    newStatus: value!,
                                  );
                                },
                              ),
                      ],
                    );
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
