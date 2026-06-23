import 'package:hive_flutter/hive_flutter.dart';
import 'package:task/features/home/domain/entites/posts_entite.dart';

abstract class HomeLocalDataSource {
  Future<List<PostsModel>> featchPosts();
}

class HomeLocalDataSourceImpl extends HomeLocalDataSource {
  @override
  Future<List<PostsModel>> featchPosts() async {
    var box = Hive.box<PostsModel>('postsBox');
    List<PostsModel> users = box.values.toList();
    return users;
  }
}
