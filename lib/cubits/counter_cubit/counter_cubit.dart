import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState.initial());

  void increment() {
    final newState = state.copyWith(counter: state.counter + 1);
    // print(newState);
    emit(newState);
  }

  void decrement() {
    if (state.counter > 0) {
      emit(state.copyWith(counter: state.counter - 1));
    }
  }
}
