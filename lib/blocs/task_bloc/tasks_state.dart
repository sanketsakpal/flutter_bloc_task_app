// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final List<Task> pendingTask;
  final List<Task> completedTask;
  final List<Task> favoriteTask;
  final List<Task> removeTask;
  
  const TasksState({
    this.pendingTask = const <Task>[],
    this.completedTask = const <Task>[],
    this.favoriteTask = const <Task>[],
    this.removeTask = const <Task>[],
  });

  @override
  List<Object> get props =>
      [pendingTask, completedTask, favoriteTask, removeTask];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pendingTask': pendingTask.map((x) => x.toMap()).toList(),
      'completedTask': completedTask.map((x) => x.toMap()).toList(),
      'favoriteTask': favoriteTask.map((x) => x.toMap()).toList(),
      'removeTask': removeTask.map((x) => x.toMap()).toList(),
    };
  }

  factory TasksState.fromMap(Map<String, dynamic> map) {
    return TasksState(
        pendingTask: List<Task>.from(
          (map['pendingTask'] as List).map<Task>(
            (x) => Task.fromMap(x as Map<String, dynamic>),
          ),
        ),
        completedTask: List<Task>.from((map['completedTask'] as List)
            .map<Task>((x) => Task.fromMap(x as Map<String, dynamic>))),
        favoriteTask: List<Task>.from((map['favoriteTask'] as List)
            .map<Task>((x) => Task.fromMap(x as Map<String, dynamic>))),
        removeTask: List<Task>.from((map['removeTask'] as List).map<Task>(
          (x) => Task.fromMap(x as Map<String, dynamic>),
        )));
  }
}
