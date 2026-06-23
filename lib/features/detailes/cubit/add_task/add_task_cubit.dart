import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:task/core/utiles/helper.dart';
import 'package:task/core/utiles/services/api_services/api_services.dart';
import 'package:task/core/utiles/services/api_services/failure.dart';

part 'add_task_state.dart';

class AddTaskCubit extends Cubit<AddTaskState> {
  AddTaskCubit() : super(AddTaskInitial());
  final formKey = GlobalKey<FormState>();

  Future<void> addTask({required String userId, required String title}) async {
    if (formKey.currentState!.validate()) {
      Get.back();
      Helper.flutterToast(message: 'Loading');
      try {
        final apiServices = ApiService.instance;

        await apiServices.post(
          'todos',
          data: {"userId": userId, "title": title, "completed": false},
        );
        Helper.flutterToast(message: 'Task Added');
      } on DioException catch (e) {
        Helper.flutterToast(message: ServerFailure.fromDiorError(e).message);
      }
    }
  }
}
