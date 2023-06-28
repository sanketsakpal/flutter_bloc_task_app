// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_todo_cubit.dart';

class FilterTodoState extends Equatable {
  final List<Todo> filteredTodo;
  const FilterTodoState({
    required this.filteredTodo,
  });
  factory FilterTodoState.initial() {
    return const FilterTodoState(filteredTodo: []);
  }
  @override
  List<Object> get props => [filteredTodo];

  @override
  bool get stringify => true;

  FilterTodoState copyWith({
    List<Todo>? filteredTodo,
  }) {
    return FilterTodoState(
      filteredTodo: filteredTodo ?? this.filteredTodo,
    );
  }
}
