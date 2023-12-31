import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_task_app/models/task_model.dart';

import '../bloc_export.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends HydratedBloc<TasksEvent, TasksState> {
  TasksBloc() : super(const TasksState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<MarkFavoriteOrUnMarkFavorite>(_onMarkFavoriteOrUnMarkFavorite);
    on<EditedTask>(_onEditTask);
    on<RestoreTasks>(_onRestoreTasks);
    on<DeleteAllTask>(_onDeleteAllTask);
  }
  void _onAddTask(AddTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      pendingTask: List.from(state.pendingTask)..add(event.task),
      completedTask: state.completedTask,
      favoriteTask: state.favoriteTask,
      removeTask: state.removeTask,
    ));
  }

  void _onUpdateTask(UpdateTask event, Emitter<TasksState> emit) {
    final state = this.state;
    final task = event.task;
    List<Task> pendingTask = state.pendingTask;
    List<Task> completedTask = state.completedTask;
    List<Task> favoriteTask = state.favoriteTask;
    // List<Task> pendingTask = List.from(state.pendingTask)..remove(task);
    // final int index = state.pendingTask.indexOf(task);

    if (task.isDone == false) {
      if (task.isFavorite == false) {
        pendingTask = List.from(pendingTask)..remove(task);
        completedTask = List.from(completedTask)
          ..insert(0, task.copyWith(isDone: true));
        // completedTask.insert(0, task.copyWith(isDone: true));
      } else {
        var taskIndex = favoriteTask.indexOf(task);
        pendingTask = List.from(pendingTask)..remove(task);
        completedTask.insert(0, task.copyWith(isDone: true));
        favoriteTask = List.from(favoriteTask)
          ..remove(task)
          ..insert(taskIndex, task.copyWith(isDone: true));
      }
    } else {
      if (task.isFavorite == false) {
        completedTask = List.from(completedTask)..remove(task);
        pendingTask = List.from(pendingTask)
          ..remove(task)
          ..insert(0, task.copyWith(isDone: false));
      } else {
        var taskIndex = favoriteTask.indexOf(task);
        completedTask = List.from(completedTask)..remove(task);
        pendingTask = List.from(pendingTask)
          ..insert(0, task.copyWith(isDone: false));
        favoriteTask = List.from(favoriteTask)
          ..remove(task)
          ..insert(
              taskIndex,
              task.copyWith(
                isDone: false,
              ));
      }
      // }
      // task.isDone == false
      //     ? {
      //         pendingTask = List.from(pendingTask)..remove(task),
      //         completedTask = List.from(completedTask)
      //           ..insert(0, task.copyWith(isDone: true))
      //         // pendingTask.insert(0, task.copyWith(isDone: true)),
      //       }
      //     : {
      //         completedTask = List.from(completedTask)..remove(task),
      //         pendingTask = List.from(pendingTask)
      //           ..insert(0, task.copyWith(isDelete: false))
      //         // pendingTask.insert(0, task.copyWith(isDone: false))
    }
    emit(TasksState(
      pendingTask: pendingTask,
      completedTask: completedTask,
      favoriteTask: favoriteTask,
      removeTask: state.removeTask,
    ));
  }

  void _onDeleteTask(DeleteTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTask: state.pendingTask,
        completedTask: state.completedTask,
        favoriteTask: state.favoriteTask,
        removeTask: List.from(state.removeTask)..remove(event.task)));
  }

  void _onRemoveTask(RemoveTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
        pendingTask: List.from(state.pendingTask)..remove(event.task),
        completedTask: List.from(state.completedTask)..remove(event.task),
        favoriteTask: List.from(state.favoriteTask)..remove(event.task),
        removeTask: List.from(state.removeTask)
          ..add(event.task.copyWith(isDelete: true))));
  }

  void _onMarkFavoriteOrUnMarkFavorite(
      MarkFavoriteOrUnMarkFavorite event, Emitter<TasksState> emit) {
    final state = this.state;
    List<Task> pendingTask = state.pendingTask;
    List<Task> completedTask = state.completedTask;
    List<Task> favoriteTask = state.favoriteTask;
    if (event.task.isDone == false) {
      if (event.task.isFavorite == false) {
        var taskIndex = pendingTask.indexOf(event.task);
        pendingTask = List.from(pendingTask)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isFavorite: true),
          );
        favoriteTask.insert(
          0,
          event.task.copyWith(isFavorite: true),
        );
      } else {
        var taskIndex = pendingTask.indexOf(event.task);
        pendingTask = List.from(pendingTask)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isFavorite: false),
          );
        favoriteTask.remove(event.task);
      }
    } else {
      if (event.task.isFavorite == false) {
        var taskIndex = completedTask.indexOf(event.task);
        completedTask = List.from(completedTask)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isFavorite: true),
          );

        favoriteTask = List.from(favoriteTask)
          ..remove(event.task)
          ..insert(0, event.task.copyWith(isFavorite: true));
      } else {
        var taskIndex = completedTask.indexOf(event.task);
        completedTask = List.from(completedTask)
          ..remove(event.task)
          ..insert(
            taskIndex,
            event.task.copyWith(isFavorite: false),
          );

        favoriteTask = List.from(favoriteTask)..remove(event.task);
      }
    }

    emit(TasksState(
      pendingTask: pendingTask,
      completedTask: completedTask,
      favoriteTask: favoriteTask,
      removeTask: state.removeTask,
    ));
  }

  void _onEditTask(EditedTask event, Emitter<TasksState> emit) {
    final state = this.state;

    List<Task> favoriteTask = state.favoriteTask;
    if (event.oldTask.isFavorite == true) {
      favoriteTask
        ..remove(event.oldTask)
        ..insert(0, event.newTask);
    }
    emit(TasksState(
        pendingTask: List.from(state.pendingTask)
          ..remove(event.oldTask)
          ..insert(0, event.newTask),
        completedTask: state.completedTask..remove(event.oldTask),
        favoriteTask: favoriteTask,
        removeTask: state.removeTask));
  }

  void _onRestoreTasks(RestoreTasks event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(
      TasksState(
        removeTask: List.from(state.removeTask)..remove(event.task),
        pendingTask: List.from(state.pendingTask)
          ..insert(
            0,
            event.task
                .copyWith(isDelete: false, isFavorite: false, isDone: false),
          ),
        completedTask: state.completedTask,
        favoriteTask: state.favoriteTask,
      ),
    );
  }

  void _onDeleteAllTask(DeleteAllTask event, Emitter<TasksState> emit) {
    final state = this.state;
    emit(TasksState(
      removeTask: List.from(state.removeTask)..clear(),
      pendingTask: state.pendingTask,
      completedTask: state.completedTask,
      favoriteTask: state.favoriteTask,
    ));
  }

  @override
  TasksState? fromJson(Map<String, dynamic> json) {
    return TasksState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TasksState state) {
    return state.toMap();
  }
}
