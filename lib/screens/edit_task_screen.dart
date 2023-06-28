import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/models/task_model.dart';
import 'package:intl/intl.dart';

import '../blocs/bloc_export.dart';

class EditTaskScreen extends StatelessWidget {
  const EditTaskScreen({
    Key? key,required this.oldTask,
  }) : super(key: key);
final Task oldTask;
  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: oldTask.title);
    TextEditingController descriptionController = TextEditingController(text: oldTask.description);
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'Edit task',
            style: TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autofocus: true,
            controller: titleController,
            decoration: const InputDecoration(
                label: Text("title"), border: OutlineInputBorder()),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            autofocus: true,
            controller: descriptionController,
            minLines: 3,
            maxLines: 5,
            decoration: const InputDecoration(
                label: Text("Description"), border: OutlineInputBorder()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () {
                    final editedTask = Task(
                      date:(DateFormat().add_yMEd().format(DateTime.now())) ,
                        uuid:  oldTask.uuid,
                        title: titleController.text,
                        isFavorite: oldTask.isFavorite,
                        isDone: false,
                        description: descriptionController.text);
                    context.read<TasksBloc>().add(EditedTask(oldTask: oldTask,newTask: editedTask));
                    titleController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text('Add'))
            ],
          )
        ],
      ),
    );
  }
}
