import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';
import 'package:flutter_bloc_task_app/widgets/task_list.dart';

import 'drawer.dart';

class RecycleBin extends StatelessWidget {
  const RecycleBin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Recycle Bin"),
            actions: [
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    onTap: ()=> context.read<TasksBloc>().add(DeleteAllTask()),
                      child: TextButton.icon(
                        
                          onPressed: () {
                             context.read<TasksBloc>().add(DeleteAllTask());
                          },
                          icon: const Icon(Icons.delete_forever),
                          label: const Text('Delete all task ')))
                ],
              )
            ],
          ),
          drawer: const DrawerScreen(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Chip(label: Text('${state.removeTask.length} Task')),
              ),
              TaskList(taskList: state.removeTask)
            ],
          ),
        );
      },
    );
  }
}
