

// ignore_for_file: public_member_api_docs, sort_constructors_first


import 'package:equatable/equatable.dart';



// ignore: must_be_immutable
class CounterColorState extends Equatable {
 int counter;
  CounterColorState({
    required this.counter,
  });



 factory CounterColorState.initial() {
    return CounterColorState(counter:0 );
  }
  @override
  List<Object> get props => [counter];


  @override
  bool get stringify => true;

  CounterColorState copyWith({
    int? counter,
  }) {
    return CounterColorState(
     counter: counter ?? this.counter,
    );
  }
}
