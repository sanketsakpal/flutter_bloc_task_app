// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';
import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/filter_cubit/filter_cubit.dart';

import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/search_cubit/todo_search_cubit.dart';

import 'package:flutter_bloc_task_app/cubits/todo_app_cubits/todo_list_cubit/todo_list_cubit.dart';
import 'package:flutter_bloc_task_app/models/todo_task_model.dart';

part 'filter_todo_state.dart';

class FilterTodoCubit extends Cubit<FilterTodoState> {
  final List<Todo> initialTodo;
  late StreamSubscription todoFilterStreamSubscription;
  late StreamSubscription todoSearchStreamSubscription;
  late StreamSubscription todoListStreamSubscription;

  final FilterCubit todoFilterCubit;
  final TodoSearchCubit todoSearchCubit;
  final TodoListCubit todoListCubit;
  FilterTodoCubit({
    required this.initialTodo,
    required this.todoFilterCubit,
    required this.todoSearchCubit,
    required this.todoListCubit,
  }) : super(FilterTodoState.initial()) {
    todoFilterStreamSubscription =
        todoFilterCubit.stream.listen((FilterState todoFilterState) {
      // setFilteredTodo();
    });

    todoSearchStreamSubscription =
        todoSearchCubit.stream.listen((TodoSearchState todoSearchState) {
      // setFilteredTodo();
    });

    todoListStreamSubscription =
        todoListCubit.stream.listen((TodoListState todoListState) {
      // setFilteredTodo();
    });
  }

  void setFilteredTodo(Filter filter, List<Todo> todo, String searchTerm) {
    List<Todo> filteredTodo;

    switch (todoFilterCubit.state.filter) {
      case Filter.active:
        filteredTodo = todoListCubit.state.todo
            .where((Todo todo) => !todo.completed)
            .toList();
        break;
      case Filter.completed:
        filteredTodo = todoListCubit.state.todo
            .where((Todo todo) => todo.completed)
            .toList();
        break;
      case Filter.all:
      default:
        filteredTodo = todoListCubit.state.todo;
        break;
    }

    if (todoSearchCubit.state.searchTerm.isNotEmpty) {
      filteredTodo = filteredTodo
          .where((Todo todo) => todo.desc
              .toLowerCase()
              .contains(todoSearchCubit.state.searchTerm))
          .toList();
    }

    emit(state.copyWith(filteredTodo: filteredTodo));
  }

  @override
  Future<void> close() {
    todoFilterStreamSubscription.cancel();
    todoSearchStreamSubscription.cancel();
    todoListStreamSubscription.cancel();
    return super.close();
  }
}
