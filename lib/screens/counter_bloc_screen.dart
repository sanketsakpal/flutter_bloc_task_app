import 'package:flutter/material.dart';
import 'package:flutter_bloc_task_app/blocs/bloc_export.dart';
import 'package:flutter_bloc_task_app/blocs/counter_bloc/counter_bloc.dart';
import 'package:flutter_bloc_task_app/cubits/counter_cubit/counter_cubit.dart';

class CounterBlocScreen extends StatelessWidget {
  const CounterBlocScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocProvider(
        create: (context) => CounterBloc(),
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(),
              body: BlocListener<CounterBloc, CounterState>(
                listener: (context, state) {
                  if (state.counter == 3) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text('counter is ${state.counter}'),
                        );
                      },
                    );
                  } else if (state.counter == -1) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) {
                    //     return OtherPage();
                    //   }),
                    // );
                  }
                },
                child: Center(
                  child: Text(
                    '${context.watch<CounterBloc>().state.counter}',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              floatingActionButton: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: () {
           context.read<CounterBloc>().add(IncrementCounterEvent());
                    },
                    heroTag: 'increment',
                    child: const Icon(Icons.add),
                  ),
                  const SizedBox(width: 10.0),
                  FloatingActionButton(
                    onPressed: () {
                         context.read<CounterBloc>().add(DecrementCounterEvent());
                    },
                    heroTag: 'decrement',
                    child: const Icon(Icons.remove),
                  ),
                ],
              ),
            );
          }
        ),
      );
    });
  }
}
