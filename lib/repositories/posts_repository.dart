import 'package:flutter_bloc_task_app/models/covid_data_model.dart';
import 'package:flutter_bloc_task_app/models/post_model.dart';
import 'package:flutter_bloc_task_app/service/post_service.dart';

class PostsRepository {
  final PostsService service;

  PostsRepository(this.service);

  Future<List<Post>> fetchPosts(int page) async {
    final posts = await service.fetchPosts(page);
    return posts.map((e) => Post.fromJson(e)).toList();
  }

  Future<CovidModel> getCovidList() {
    return service.fetchCovidList();
  }
}
