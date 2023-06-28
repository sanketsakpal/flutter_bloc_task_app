import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/models/task_model.dart';
import 'package:flutter_bloc_task_app/widgets/task_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    Key? key,
    required this.taskList,
  }) : super(key: key);

  final List<Task> taskList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: ExpansionPanelList.radio(
            children: taskList
                .map(
                  (task) => ExpansionPanelRadio(
                    value: task.uuid,
                    headerBuilder: (context, isExpanded) =>
                        TasksTile(task: task),
                    body: ListTile(
                      title: SelectableText.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'task\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: task.title),
                            const TextSpan(
                              text: '\n\nDescription\n',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: task.description),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
                .toList()),
      ),
    );

    // Expanded(
    //   child: ListView.builder(
    //     shrinkWrap: true,
    //     itemCount: taskList.length,
    //     itemBuilder: (context, index) {
    //       final task = taskList[index];
    //       return TasksTile(task: task);
    //     },
    //   ),
    // );
  }
}
