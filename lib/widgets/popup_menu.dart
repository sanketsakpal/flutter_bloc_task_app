

import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/models/task_model.dart';

class PopupMenu extends StatelessWidget {
const  PopupMenu(
      {Key? key,
      required this.onDeletePress,
      required this.task,
      required this.onLikeOrDislikeTask,
      required this.onEditTaskPress,
      required this.onRestorePress,
      })
      : super(key: key);
  final Task task;
  final VoidCallback onDeletePress;
  final VoidCallback onLikeOrDislikeTask;
  final VoidCallback onEditTaskPress;
  final VoidCallback onRestorePress;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDelete == false
          ? (context) => [
                PopupMenuItem(
                  onTap: null,
                  child: TextButton.icon(
                    onPressed: onEditTaskPress,
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),
                PopupMenuItem(
                  onTap: onLikeOrDislikeTask,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: task.isFavorite == false
                        ? const Icon(Icons.bookmark_add_outlined)
                        : const Icon(Icons.bookmark_remove),
                    label: task.isFavorite == false
                        ? const Text('Add to Bookmark')
                        : const Text('Remove from Bookmark'),
                  ),
                ),
                PopupMenuItem(
                  onTap: onDeletePress,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                ),
              ]
          : (context) => [
                PopupMenuItem(
                  onTap: (){},
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.restore),
                    label: const Text('Restore'),
                  ),
                ),
                PopupMenuItem(
                  onTap: onDeletePress,
                  child: TextButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.delete_forever),
                    label: const Text('Delete Forever'),
                  ),
                ),
              ],
    );
  }
}
