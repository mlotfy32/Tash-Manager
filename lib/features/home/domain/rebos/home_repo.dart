import 'package:dartz/dartz.dart';
import 'package:task/core/utiles/services/api_services/failure.dart';
import 'package:task/features/home/domain/entites/posts_entite.dart';

abstract class HomeRebo {
  Future<Either<Failure, List<PostsModel>>> featchUsers();
}
