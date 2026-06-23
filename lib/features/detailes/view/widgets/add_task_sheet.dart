import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:task/core/utiles/app_fonts.dart';
import 'package:task/core/utiles/extentions.dart';
import 'package:task/core/utiles/setup_service_locator.dart';
import 'package:task/core/utiles/validation/app_validator.dart';
import 'package:task/core/utiles/validation/field_type.dart';
import 'package:task/core/utiles/widgets/custom_text_form.dart';
import 'package:task/features/detailes/cubit/add_task/add_task_cubit.dart';

class AddTaskSheet extends StatefulWidget {
  const AddTaskSheet({super.key});

  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  late TextEditingController userId;
  late TextEditingController title;
  late AddTaskCubit addTask;
  @override
  void initState() {
    userId = TextEditingController();
    title = TextEditingController();
    addTask = sl<AddTaskCubit>();
    super.initState();
  }

  @override
  void dispose() {
    userId.dispose();
    title.dispose();
    // addTask.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      margin: EdgeInsets.only(top: 150.h),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: context.theme.primaryColor.withAlpha(80),
            blurStyle: BlurStyle.outer,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.r),
          topRight: Radius.circular(12.r),
        ),
      ),
      child: Form(
        key: addTask.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Add Task',
                style: AppFonts.f20ExtraBold0F172A().copyWith(
                  color: context.theme.primaryColor,
                ),
              ).withPadding(vertical: 16.h),
              CustomTextForm(
                controller: userId,
                hint: 'Enter Task Id',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    AppValidator.validate(value: value, type: FieldType.normal),
              ).withPadding(bottom: 16.h),
              CustomTextForm(
                controller: title,
                hint: 'Enter Task Title',
                validator: (value) =>
                    AppValidator.validate(value: value, type: FieldType.normal),
              ).withPadding(bottom: 16.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () => addTask.addTask(
                  userId: userId.text,
                  title: title.text,
                ),
                child: Text(
                  'Add Task',
                  style: AppFonts.f20ExtraBold0F172A().copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
