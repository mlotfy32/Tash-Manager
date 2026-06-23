import 'package:dartz/dartz.dart';
import 'package:task/core/utiles/internet_connecton.dart';
import 'package:task/core/utiles/services/api_services/failure.dart';
import 'package:task/features/home/data/data_source/home_local_data_source.dart';
import 'package:task/features/home/data/data_source/home_remote_data_source.dart';
import 'package:task/features/home/domain/entites/posts_entite.dart';
import 'package:task/features/home/domain/rebos/home_repo.dart';

class HomeReboImp extends HomeRebo {
  final HomeLocalDataSource homeLocalDataSource;
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeReboImp({
    required this.homeLocalDataSource,
    required this.homeRemoteDataSource,
  });
  @override
  Future<Either<Failure, List<PostsModel>>> featchUsers() async {
    List<PostsModel> users;

    try {
      bool isConnected = await CheckInternetConnection.instance.checkInternet();
      if (isConnected) {
        users = await homeRemoteDataSource.featchPosts();
        if (users.isNotEmpty) {
          return right(users);
        }
      } 
        users = await homeLocalDataSource.featchPosts();
        return right(users);
      
    } on Exception catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
