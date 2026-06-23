import 'package:task/features/home/domain/entites/posts_entite.dart';

class HomeModel extends PostsModel {
  HomeModel({
    required super.userId,
    required super.id,
    required super.title,
    required super.body,
    required super.completed,
  });
  factory HomeModel.fromJson(json) {
    return HomeModel(
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      body: json['body'],
      completed: json['body'],
    );
  }
}
