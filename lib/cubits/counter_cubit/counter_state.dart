// ignore_for_file: public_member_api_docs, sort_constructors_first


part of 'counter_cubit.dart';

// ignore: must_be_immutable
class CounterState extends Equatable {
 int counter;
  CounterState({
    required this.counter,
  });



 factory CounterState.initial() {
    return CounterState(counter:0 );
  }
  @override
  List<Object> get props => [counter];


  @override
  bool get stringify => true;

  CounterState copyWith({
    int? counter,
  }) {
    return CounterState(
     counter: counter ?? this.counter,
    );
  }
}
