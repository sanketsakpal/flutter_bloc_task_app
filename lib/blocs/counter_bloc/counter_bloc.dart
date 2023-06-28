import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';
import 'package:flutter_bloc_task_app/cubits/counter_cubit/counter_cubit.dart';

part 'counter_event.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState.initial()) {
    on<IncrementCounterEvent>(_incrementCounterEvent);

    on<DecrementCounterEvent>(_decrementCounterEvent);
  }

  void _incrementCounterEvent(
      IncrementCounterEvent event, Emitter<CounterState> emit) {
    emit(state.copyWith(counter: state.counter + 1));
  }

  void _decrementCounterEvent(
      DecrementCounterEvent event, Emitter<CounterState> emit) {
    if (state.counter > 0) {
      emit(state.copyWith(counter: state.counter - 1));
    }
  }
}
