part of 'get_tasks_cubit.dart';

@immutable
sealed class GetTasksState {}

final class GetTasksInitial extends GetTasksState {}

final class GetTasksLoading extends GetTasksState {}

final class GetTasksSuccess extends GetTasksState {
  final List<PostsModel> posts;

  GetTasksSuccess({required this.posts});
}

final class GetTasksFailure extends GetTasksState {
  final String errorMessage;

  GetTasksFailure({required this.errorMessage});
}
