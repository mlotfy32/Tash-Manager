import 'package:hive/hive.dart';
import 'package:task/core/utiles/services/api_services/api_services.dart';
import 'package:task/features/home/domain/entites/posts_entite.dart';

abstract class HomeRemoteDataSource {
  Future<List<PostsModel>> featchPosts();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiService apiservice;

  HomeRemoteDataSourceImpl({required this.apiservice});

  @override
  Future<List<PostsModel>> featchPosts() async {
    final postsData = await apiservice.get('posts');
    final todosData = await apiservice.get('todos');

    final List todos = todosData;

final List<PostsModel> posts = (postsData as List).map((post) {
  final todo = todos.firstWhere(
    (todo) => todo['userId'] == post['userId'],
    orElse: () => <String, dynamic>{'completed': false},
  );

  return PostsModel(
    userId: post['userId'],
    id: post['id'],
    title: post['title'],
    body: post['body'],
    completed: todo['completed'],
  );
}).toList();

    _saveBox(posts, 'postsBox');

    return posts;
  }

  void _saveBox(List<PostsModel> posts, String boxName) {
    if (!Hive.isBoxOpen(boxName)) return;

    final box = Hive.box<PostsModel>(boxName);
    box.clear();
    box.addAll(posts);
  }
}