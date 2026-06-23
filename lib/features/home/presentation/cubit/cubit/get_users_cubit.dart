
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task/features/home/domain/entites/posts_entite.dart';
import 'package:task/features/home/domain/use_case/featch_users_usecase.dart';

part 'get_users_state.dart';

class GetUsersCubit extends Cubit<GetUsersState> {
  GetUsersCubit({required this.useCase}) : super(GetUsersInitial());
  final FeatchUsersUsecase useCase;
  Future<void> feachPosts() async {
    emit(GetUsersLoading());
    var result = await useCase.call();
    result.fold(
      (failure) {
        emit(GetUsersFailure(errorMessage: failure.message));
      },
      (success) {
        emit(GetUsersSuccess(posts: success));
      },
    );
  }
}
