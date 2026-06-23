import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
  return Padding(
    padding: EdgeInsets.only(
      bottom: MediaQuery.of(context).viewInsets.bottom,
    ),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withAlpha(60),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      child: Form(
        key: addTask.formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min, // ⭐ مهم جدًا
            children: [
              Text(
                'Add Task',
                style: AppFonts.f20ExtraBold0F172A().copyWith(
                  color: Theme.of(context).primaryColor,
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
                onPressed: () {
                  if (addTask.formKey.currentState!.validate()) {
                    addTask.addTask(
                      userId: userId.text,
                      title: title.text,
                    );
                    context.pop();
                  }
                },
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
    ),
  );
}
}
