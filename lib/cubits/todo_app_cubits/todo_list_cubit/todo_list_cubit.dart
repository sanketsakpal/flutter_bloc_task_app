import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';
import 'package:flutter_bloc_task_app/models/todo_task_model.dart';

part 'todo_list_state.dart';

class TodoListCubit extends Cubit<TodoListState> {
  TodoListCubit() : super(TodoListState.initial());
  void addTodo(String todoDesc) {
    final newTodo = Todo(desc: todoDesc);
    final newTodoS = [...state.todo, newTodo];
    emit(state.copyWith(todo: newTodoS));
    // print(state);
  }

  void editTodo(String id, String todoDesc) {
    final newTodoS = state.todo.map((Todo todo) {
      if (todo.id == id) {
        return Todo(id: id, desc: todoDesc, completed: todo.completed);
      }

      return todo;
    }).toList();
    emit(state.copyWith(todo: newTodoS));
  }

  void toggleTodo(String id) {
    final newTodoS = state.todo.map((Todo todo) {
      if (todo.id == id) {
        return Todo(id: id, desc: todo.desc, completed: !todo.completed);
      }

      return todo;
    }).toList();
    emit(state.copyWith(todo: newTodoS));
  }

  void removeTodo(Todo todo) {
    final newTodoS = state.todo.where((Todo t) => t.id != todo.id).toList();
    emit(state.copyWith(todo: newTodoS));
  }
}
