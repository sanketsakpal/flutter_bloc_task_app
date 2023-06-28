import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/active_count_cubit/active_count_cubit.dart';
import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/todo_list_cubit/todo_list_cubit.dart';
import 'package:flutter_bloc_task_app/models/todo_task_model.dart';

class TodoHeader extends StatelessWidget {
  const TodoHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'TODO',
          style: TextStyle(fontSize: 40.0),
        ),
        BlocListener<TodoListCubit, TodoListState>(
          listener: (context, state) {
            final int activeTodoCount = state.todo
                .where((Todo todo) => !todo.completed)
                .toList()
                .length;
            context
                .read<ActiveCountCubit>()
                .calculateActiveTodoCount(activeTodoCount);
          },
          child: BlocBuilder<ActiveCountCubit, ActiveCountState>(
            builder: (context, state) {
              return Text(
                '${state.activeCount} items left',
                style:const TextStyle(fontSize: 20.0, color: Colors.redAccent),
              );
            },
          ),
        ),
        // Text(
        //   '${context.watch<ActiveCountCubit>().state.activeCount} items left',
        //   style: TextStyle(fontSize: 20.0, color: Colors.redAccent),
        // ),
      ],
    );
  }
}
