import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/models/task_model.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../blocs/bloc_export.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Text(
            'add task',
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
                    final task = Task(
                      date:(DateFormat().add_yMEd().format(DateTime.now())) ,
                        uuid:  const Uuid().v4(),
                        title: titleController.text,
                        description: descriptionController.text);
                    context.read<TasksBloc>().add(AddTask(task: task));
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
