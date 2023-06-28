import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/filter_cubit/filter_cubit.dart';
import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/filter_todo_cubit/filter_todo_cubit.dart';
import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/search_cubit/todo_search_cubit.dart';
import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/todo_list_cubit/todo_list_cubit.dart';
import 'package:flutter_bloc_task_app/models/todo_task_model.dart';

// class ShowTodo extends StatelessWidget {
//   const ShowTodo({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final todo = context.watch<FilterTodoCubit>().state.filteredTodo;
//     return ListView.separated(
//         primary: false,
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           return Text(
//             todo[index].desc,
//             style: TextStyle(fontSize: 20),
//           );
//         },
//         separatorBuilder: (context, index) {
//           return const Divider();
//         },
//         itemCount: todo.length);
//   }
// }

class ShowTodo extends StatelessWidget {
  const ShowTodo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = context.watch<FilterTodoCubit>().state.filteredTodo;

    return MultiBlocListener(
      listeners: [
        BlocListener<TodoListCubit, TodoListState>(
          listener: (context, state) {
            context.read<FilterTodoCubit>().setFilteredTodo(
                  context.read<FilterCubit>().state.filter,
                  state.todo,
                  context.read<TodoSearchCubit>().state.searchTerm,
                );
          },
        ),
        BlocListener<FilterCubit, FilterState>(
          listener: (context, state) {
            context.read<FilterTodoCubit>().setFilteredTodo(
                  state.filter,
                  context.read<TodoListCubit>().state.todo,
                  context.read<TodoSearchCubit>().state.searchTerm,
                );
          },
        ),
        BlocListener<TodoSearchCubit, TodoSearchState>(
          listener: (context, state) {
            context.read<FilterTodoCubit>().setFilteredTodo(
                  context.read<FilterCubit>().state.filter,
                  context.read<TodoListCubit>().state.todo,
                  state.searchTerm,
                );
          },
        ),
      ],
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        itemCount: todo.length,
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(color: Colors.grey);
        },
        itemBuilder: (BuildContext context, int index) {
          return Dismissible(
            key: ValueKey(todo[index].id),
            background: showBackground(0),
            secondaryBackground: showBackground(1),
            onDismissed: (_) {
              context.read<TodoListCubit>().removeTodo(todo[index]);
            },
            confirmDismiss: (_) {
              return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Are you sure?'),
                    content: const Text('Do you really want to delete?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('NO'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('YES'),
                      ),
                    ],
                  );
                },
              );
            },
            child: TodoItem(todo: todo[index]),
          );
        },
      ),
    );
  }

  Widget showBackground(int direction) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      color: Colors.red,
      alignment: direction == 0 ? Alignment.centerLeft : Alignment.centerRight,
      child: const Icon(
        Icons.delete,
        size: 30.0,
        color: Colors.white,
      ),
    );
  }
}

class TodoItem extends StatefulWidget {
  final Todo todo;
  const TodoItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  late final TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            bool error = false;
            textController.text = widget.todo.desc;

            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return AlertDialog(
                  title: const Text('Edit Todo'),
                  content: TextField(
                    controller: textController,
                    autofocus: true,
                    decoration: InputDecoration(
                      errorText: error ? "Value cannot be empty" : null,
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('CANCEL'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          error = textController.text.isEmpty ? true : false;
                          if (!error) {
                            context.read<TodoListCubit>().editTodo(
                                  widget.todo.id,
                                  textController.text,
                                );
                            Navigator.pop(context);
                          }
                        });
                      },
                      child:const Text('EDIT'),
                    ),
                  ],
                );
              },
            );
          },
        );
      },
      leading: Checkbox(
        value: widget.todo.completed,
        onChanged: (bool? checked) {
          context.read<TodoListCubit>().toggleTodo(widget.todo.id);
        },
      ),
      title: Text(widget.todo.desc),
    );
  }
}
