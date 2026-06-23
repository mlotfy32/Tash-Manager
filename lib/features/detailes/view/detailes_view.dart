import 'package:flutter/material.dart';
import 'package:task/features/detailes/view/widgets/detailes_view_body.dart';
import 'package:task/features/home/domain/entites/posts_entite.dart';

class DetailesView extends StatelessWidget {
  const DetailesView({
    super.key,
    required this.postsModel,

  });
  final PostsModel postsModel;

  @override
  Widget build(BuildContext context) {
    return  DetailesViewBody(
      postsModel: postsModel,

    );
  }
}
