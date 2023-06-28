




import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/models/post_model.dart';

@immutable
abstract class PostsState {}

class PostsInitial extends PostsState {}
class PostsLoaded extends PostsState {
  final List<Post> posts;

  PostsLoaded(this.posts);
}

class PostsLoading extends PostsState {
  final List<Post> oldPosts;
  final bool isFirstFetch;

  PostsLoading(this.oldPosts, {this.isFirstFetch=false});
}