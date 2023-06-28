import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/models/task_model.dart';
import 'package:flutter_bloc_task_app/widgets/task_list.dart';

import '../blocs/bloc_export.dart';

class PendingTaskScreen extends StatelessWidget {
  const PendingTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {

  

    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        List<Task> taskList = state.pendingTask;
        return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Center(
                  child: Chip(label: Text('${taskList.length} Pending | ${state.completedTask.length} Completed')),
                ),
                TaskList(taskList: taskList)
              ],
            
          
        );
      },
    );
  }
}

