import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/widgets/task_app/create_todo.dart';
import 'package:flutter_bloc_task_app/widgets/task_app/search_filter.dart';
import 'package:flutter_bloc_task_app/widgets/task_app/show_todo.dart';
import 'package:flutter_bloc_task_app/widgets/task_app/todo_headers.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 40.0,
          ),
          child: Column(
            children: [
              const TodoHeader(),
              const CreateTodo(),
              const SizedBox(height: 20.0),
              SearchAndFilterTodo(),
              const ShowTodo(),
            ],
          ),
        ),
      ),
    );
  }
}
