import 'package:hive/hive.dart';
part 'posts_entite.g.dart';

@HiveType(typeId: 1)
class PostsModel {
  @HiveField(0)
  final int userId;

  @HiveField(1)
  final int id;

  @HiveField(2)
  final String title;

  @HiveField(3)
  final String body;
  @HiveField(4)
  final bool completed;

  PostsModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
    required this.completed,
  });
}
