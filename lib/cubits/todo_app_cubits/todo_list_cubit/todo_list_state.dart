// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_list_cubit.dart';

class TodoListState extends Equatable {
  final List<Todo> todo;
  const TodoListState({
    required this.todo,
  });
  factory TodoListState.initial() {
    return const TodoListState(todo: []);
  }
  @override
  List<Object> get props => [todo];

  TodoListState copyWith({
    List<Todo>? todo,
  }) {
    return TodoListState(
      todo: todo ?? this.todo,
    );
  }
}
