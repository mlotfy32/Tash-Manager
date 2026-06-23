import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:task/core/utiles/helper.dart';
import 'package:task/core/utiles/services/api_services/api_services.dart';
import 'package:task/core/utiles/services/api_services/failure.dart';

part 'update_task_state.dart';

class UpdateTaskCubit extends Cubit<UpdateTaskState> {
  UpdateTaskCubit() : super(UpdateTaskInitial());
  Future<void> updateTaskStatus({
    required int id,
    required bool newStatus,
  }) async {
    emit(UpdateTaskLoading());
    try {
      final api = ApiService.instance;
      await api.patch('todos/$id', data: {"completed": newStatus});
      emit(UpdateTaskSuccess());
    } on DioException catch (e) {
      Helper.flutterToast(message: ServerFailure.fromDiorError(e).message);
    }catch (e) {
      emit(UpdateTaskFailure());
      Helper.flutterToast(message: 'Something went wrong');
  }
  }
}
