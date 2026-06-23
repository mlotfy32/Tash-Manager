import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:task/core/utiles/helper.dart';
import 'package:task/core/utiles/services/api_services/api_services.dart';
import 'package:task/core/utiles/services/api_services/failure.dart';
import 'package:task/features/home/domain/entites/posts_entite.dart';

part 'get_tasks_state.dart';

class GetTasksCubit extends Cubit<GetTasksState> {
  GetTasksCubit() : super(GetTasksInitial());
  Future<void> getTasks({required int userId}) async {
    try {
      emit(GetTasksLoading());

      final apiServices = ApiService.instance;

      final todosData = await apiServices.get(
        'todos',
        query: {'userId': userId},
      );

      final postData = await apiServices.get('posts/$userId');

      final String body = postData['body'] ?? '';

      final List<PostsModel> tasks = (todosData as List).map((e) {
        return PostsModel(
          userId: e['userId'],
          id: e['id'],
          title: e['title'] ?? '',
          body: body,
          completed: e['completed'] ?? false,
        );
      }).toList();

      emit(GetTasksSuccess(posts: tasks));
    } on DioException catch (e) {
      emit(
        GetTasksFailure(errorMessage: ServerFailure.fromDiorError(e).message),
      );
    } catch (e) {
      Helper.flutterToast(message: 'Something went wrong');
    }
  }
}
