import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';
import 'package:flutter_bloc_task_app/models/task_model.dart';
import 'package:flutter_bloc_task_app/screens/edit_task_screen.dart';
import 'package:flutter_bloc_task_app/widgets/popup_menu.dart';

class TasksTile extends StatelessWidget {
  const TasksTile({
    Key? key,
    required this.task,
  }) : super(key: key);

  final Task task;
  void removeOrDelete(BuildContext ctx, Task task) {
    task.isDelete!
        ? ctx.read<TasksBloc>().add(DeleteTask(task: task))
        : ctx.read<TasksBloc>().add(RemoveTask(task: task));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                task.isFavorite == false
                    ? const Icon(Icons.star_outline)
                    : const Icon(Icons.star),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 18,
                            decoration: task.isDone!
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                      Text(task.date)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        Row(
          children: [
            Checkbox(
                value: task.isDone,
                onChanged: task.isDelete == false
                    ? (value) {
                        context.read<TasksBloc>().add(UpdateTask(task: task));
                      }
                    : null),
            PopupMenu(
                onDeletePress: () {
                  removeOrDelete(context, task);
                },
                onLikeOrDislikeTask: () {
                  context
                      .read<TasksBloc>()
                      .add(MarkFavoriteOrUnMarkFavorite(task: task));
                },
                onEditTaskPress: () {
                  Navigator.of(context).pop;
                  editTask(context);
                },
                onRestorePress: () => context.read<TasksBloc>()..add(RestoreTasks(task: task)),
                task: task),
          ],
        ),
        // onLongPress: () => removeOrDelete(context, task),
      ],
    );
  }

  void editTask(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: EditTaskScreen(
            oldTask: task,
          ),
        ),
      ),
    );
  }
}
