import 'package:dartz/dartz.dart';
import 'package:task/core/utiles/services/api_services/failure.dart';
import 'package:task/features/home/domain/entites/posts_entite.dart';
import 'package:task/features/home/domain/rebos/home_repo.dart';

abstract class UseCase {
  Future<Either<Failure, List<PostsModel>>> call();
}

class FeatchUsersUsecase extends UseCase {
  final HomeRebo homeRebo;

  FeatchUsersUsecase({required this.homeRebo});
  @override
  Future<Either<Failure, List<PostsModel>>> call() async {
    return await homeRebo.featchUsers();
  }
}
