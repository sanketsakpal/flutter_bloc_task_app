import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/cubits/post_api_cubit/post_api_cubit.dart';
import 'package:flutter_bloc_task_app/cubits/post_api_cubit/post_api_state.dart';
import 'package:flutter_bloc_task_app/models/post_model.dart';
import 'package:flutter_bloc_task_app/repositories/posts_repository.dart';
import 'package:flutter_bloc_task_app/service/post_service.dart';

class PostsView extends StatelessWidget {
  final scrollController = ScrollController();

  PostsView({super.key});

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<PostsCubit>(context).loadPosts();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // setupScrollController(context);
    // BlocProvider.of<PostsCubit>(context).loadPosts();
//  PostsRepository? repository;
    return BlocProvider(
      create: (context) =>
          PostsCubit(PostsRepository(PostsService()))..loadPosts(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Posts"),
        ),
        body: Builder(builder: (context) {
          return _postList(context);
        }),
      ),
    );
  }

  Widget _postList(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
      if (state is PostsLoading && state.isFirstFetch) {
        return _loadingIndicator();
      }

      List<Post> posts = [];
      bool isLoading = false;

      if (state is PostsLoading) {
        posts = state.oldPosts;
        isLoading = true;
      } else if (state is PostsLoaded) {
        posts = state.posts;
      }

      return ListView.separated(
        controller: scrollController,
        itemBuilder: (context, index) {
          if (index < posts.length) {
            return _post(posts[index], context);
          } else {
            Timer(const Duration(milliseconds: 30), () {
              scrollController
                  .jumpTo(scrollController.position.maxScrollExtent);
            });

            return _loadingIndicator();
          }
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: posts.length + (isLoading ? 1 : 0),
      );
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

  Widget _post(Post post, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${post.id}. ${post.title}",
            style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          Text(post.body)
        ],
      ),
    );
  }
}
