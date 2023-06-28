// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';

import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/todo_list_cubit/todo_list_cubit.dart';
import 'package:flutter_bloc_task_app/models/todo_task_model.dart';

part 'active_count_state.dart';

class ActiveCountCubit extends Cubit<ActiveCountState> {
  late final StreamSubscription todoListSubscription;

  final TodoListCubit todoListCubit;
  ActiveCountCubit({required this.todoListCubit})
      : super(ActiveCountState.initial()) {
    todoListSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      // print("todoListState: $todoListState");
      final int currentActiveCount = todoListState.todo
          .where((Todo todo) => !todo.completed)
          .toList()
          .length;
      emit(state.copyWith(activeCount: currentActiveCount));
    });
  }
  void calculateActiveTodoCount(int activeTodoCount) {
    emit(state.copyWith(activeCount: activeTodoCount));
  }

  @override
  Future<void> close() {
    todoListSubscription.cancel();
    return super.close();
  }
}
