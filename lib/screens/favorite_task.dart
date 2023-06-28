import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';
import 'package:flutter_bloc_task_app/models/task_model.dart';
import 'package:flutter_bloc_task_app/widgets/task_list.dart';

class FavoriteTask extends StatelessWidget {
  const FavoriteTask({super.key});

  @override
  Widget build(BuildContext context) {
       return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.favoriteTask;
        return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Center(
                  child: Chip(label: Text('${taskList.length} Task')),
                ),
                TaskList(taskList: taskList)
              ],
            
          
        );
      },
    );
  }
}